/*
 * server.c
 *
 *  Created on: Apr 26, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *
 */

#include "my.h"
#include "list.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <signal.h>
#include <netdb.h>
#include <sys/select.h>
#include <sys/time.h>
#include <ncurses.h>

struct client_pair {
    int fd;
    char* username;
};
struct s_node *ll_head;
fd_set ll_master;
int ll_max_fd;
int MAX_BUFFER_SIZE = 256;

void error(const char *msg)
{
    perror(msg);
    exit(1);
}

struct client_pair* new_client_pair(int fd, char* username){
    /* new_client_pair allocates memory for a new struct, initializes the struct, and returns the struct*/
    struct client_pair* client;
    client = (struct client_pair*)malloc(sizeof(struct client_pair));
    client->fd = fd;
    client->username = username;
    return client;
}

char* processing(int fd, char* message) {
    struct client_pair* temp;
    int i, c;
    char* ret;
    char* check;
    //gets correct node from linked list
    for (i = 0; i < count_s_nodes(ll_head); i++) {
        temp = (struct client_pair*)elem_at(ll_head, i);
        c = i;
        if (temp->fd == fd) {
            break;
        }
    }
    ret = temp->username;
    check = my_strdup(message);
    for (i = 0; check[i] != '\0'; i++) {
        if (check[i] == ' ' || check[i] == '\t') {
            check[i] = '\0';
        }
    }
    if (my_strcmp(check, "/exit") == 0) {
        free(remove_node_at(&ll_head, c));
        FD_CLR(fd, &ll_master);
        close(fd);
        ret = my_strconcat(ret, " has disconnected\n");
        return ret;
    }
    else if (my_strcmp(check, "/nick") == 0) {
        if (my_strlen(message) <= 6) {
            ret = "Error: invalid username\n";
            if (write(fd, ret, my_strlen(ret)) < 0) {
                error("ERROR writing");
                exit(0);
            }
            return NULL;
        }
        else {
            message += 6;
            temp->username = my_strdup(message);
            ret = my_strconcat(ret, " has changed their username to ");
            ret = my_strconcat(ret, message);
            ret = my_strconcat(ret, "\n");
            return ret;
        }
    }
    else if (my_strcmp(check, "/me") == 0) {
        if (my_strlen(message) == 3) {
            ret = my_strconcat(ret, "\n");
            return ret;
        }
        else {
            message += 4;
            ret = my_strconcat(ret, " ");
            ret = my_strconcat(ret, message);
            ret = my_strconcat(ret, "\n");
            return ret;
        }
        
    }
    else if (my_strncmp(check, "/", 1) == 0) {
        ret = "Error: invalid command innvocation\n";
        if (write(fd, ret, my_strlen(ret)) < 0) {
            error("ERROR writing");
            exit(0);
        }
        return NULL;
    }
    else {
        ret = my_strconcat(ret, ": ");
        ret = my_strconcat(ret, message);
        ret = my_strconcat(ret, "\n");
        return ret;
    }
    
}

void send_message(int listen, char* message){
    int j;
    for (j = 3; j <= ll_max_fd; j++) {
        if (FD_ISSET(j, &ll_master)) {
            if (j != listen) {
                if (write(j, message, my_strlen(message)) < 0) {
                    error("ERROR writing");
                    exit(0);
                }
            }
        }
    }
}


int main(int argc, char *argv[])
{  
    fd_set readfds;
    struct sockaddr_in serv_addr;
    struct sockaddr_in cli_addr;
    int listener, newsockfd, bytes_read, portno;
    socklen_t clilen;
    char buffer[MAX_BUFFER_SIZE];
    int i, k;
    char* message;
    struct client_pair* temp;
    
    if (argc != 2) {
        my_str("Usage: ./server [port]\n");
        exit(0);
    } 
    
    ll_head = (struct s_node*)malloc(sizeof(struct s_node));
    portno = my_atoi(argv[1]);
    if (portno < 0) {
        my_str("Invalid port!\n");
        exit(0);
    }
    
    FD_ZERO(&ll_master);
    FD_ZERO(&readfds);
    if ((listener = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        error("Error opening socket");
        exit(0);
    }
    my_str("Socket successfully created\n");
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);
    memset(&(serv_addr.sin_zero), '\0', 8);
    
    if(bind(listener, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
        error("ERROR on binding");
        exit(0);
    }
    my_str("bind successful!\n");
    if (listen(listener, 5) < 0) {
        error("ERROR listening");
        exit(0);
    }
    my_str("listen successful!\n");
    
    FD_SET(listener, &ll_master);
    ll_max_fd = listener;
    
    while(1) {
        readfds = ll_master;
        if (select(ll_max_fd + 1, &readfds, NULL, NULL, NULL) < 0) {
            error("ERROR selecting");
            exit(0);
        }
        for (i = 3; i <= ll_max_fd; i++) {
            if (FD_ISSET(i, &readfds)) {
                if (i == listener) {
                    clilen = sizeof(cli_addr);
                    if ((newsockfd = accept(listener, (struct sockaddr*)&cli_addr, &clilen))< 0) {
                        error("ERROR accepting");
                        exit(0);
                    }
                    bytes_read = read(newsockfd, buffer, MAX_BUFFER_SIZE - 1);
                    if (bytes_read < 0) {
                        error("ERROR reading");
                        exit(0);
                    }
                    buffer[bytes_read] = '\0';
                    FD_SET(newsockfd, &ll_master);
                    if (newsockfd > ll_max_fd) {
                        ll_max_fd = newsockfd;
                    }
                    add_elem(new_client_pair(newsockfd, my_strdup(buffer)), &ll_head);
                    message = my_strconcat(buffer, " has connected\n");
                    send_message(listener, message);
                    my_str(message);
                }
                else {
                    bytes_read = read(i, buffer, MAX_BUFFER_SIZE - 1);
                    if (bytes_read == 0) {
                        for (k = 0; k < count_s_nodes(ll_head); k++) {
                            temp = (struct client_pair*)elem_at(ll_head,k);
                            if (temp->fd == i) {
                                message = temp->username;
                                free(remove_node_at(&ll_head, k));
                                break;
                            }
                        }
                        message = my_strconcat(message, " has disconnected\n");
                        send_message(listener, message);
                        my_str(message);
                        FD_CLR(i, &ll_master);
                        close(i);
                        continue;
                    }
                    if (bytes_read < 0) {
                        error("ERROR reading");
                        exit(0);
                    }
                    buffer[bytes_read] = '\0';
                    message = processing(i, buffer);
                    if (message != NULL) {
                        my_str(message);
                        send_message(listener, message);
                    }
                }
            }
        }
        
        
        
        
        
        
        
        
    }
    
    return 0;
    
    /*int sockfd, newsockfd, portno;
     socklen_t clilen;
     char buffer[256];
     struct sockaddr_in serv_addr, cli_addr;
     int n;
     if (argc < 2) {
         fprintf(stderr,"ERROR, no port provided\n");
         exit(1);
     }
     sockfd = socket(AF_INET, SOCK_STREAM, 0); //udp
     if (sockfd < 0) 
        error("ERROR opening socket");
     bzero((char *) &serv_addr, sizeof(serv_addr));//memset
     portno = atoi(argv[1]);//string to integer
     serv_addr.sin_family = AF_INET;
     serv_addr.sin_addr.s_addr = INADDR_ANY;
     serv_addr.sin_port = htons(portno);//convert to big or little indian notation
     if (bind(sockfd, (struct sockaddr *) &serv_addr, //create server on specific port
              sizeof(serv_addr)) < 0) 
              error("ERROR on binding");
     listen(sockfd,5); //listen on that port, 5 is backlog max #. listen is blocking system call
     clilen = sizeof(cli_addr); //length of client address
     newsockfd = accept(sockfd, //accept file client
                 (struct sockaddr *) &cli_addr, 
                 &clilen);
     if (newsockfd < 0) 
          error("ERROR on accept");
     bzero(buffer,256);
     n = read(newsockfd,buffer,255); // read from client
     if (n < 0) error("ERROR reading from socket");
     printf("Here is the message: %s\n",buffer); //print info
     n = write(newsockfd,"I got your message",18); //write to client
     if (n < 0) error("ERROR writing to socket");
     close(newsockfd);
     close(sockfd);
     return 0; */
}
