/*
 * client.c
 *
 *  Created on: Apr 26, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *
 */

//#include "socket.h"
#include "my.h"
#include "list.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h> 
#include <signal.h>
#include <sys/select.h>
#include <sys/time.h>
#include <ncurses.h>


void error(const char *msg)
{
    perror(msg);
    exit(0);
}

int main(int argc, char *argv[])
{
    int sockfd, portno, n; // setting up socket on client
    int MAX_BUFFER_SIZE = 256;
    struct sockaddr_in serv_addr;
    struct hostent *server;

    char buffer[MAX_BUFFER_SIZE];
    fd_set master;
    fd_set readfds;
    char *username;
    char *msg;
    char *temp;
    
    if (argc != 3) {
       my_str("usage error: ./client [host] [port] \n");
       exit(0);
    }
    /*set fds to zeros*/
    FD_ZERO(&master);
    FD_ZERO(&readfds);
    username = NULL;//set username to null before retrieval
    do {
        my_str("Please enter a username: ");
        n = read(0, buffer, MAX_BUFFER_SIZE - 1);
        
        if (n < 0) {
            error("read() error"), exit(0);
        }
        buffer[n-1] = '\0';
        username = my_strdup(buffer);
    } while (my_strlen(username) < 1);
    
    portno = atoi(argv[2]);
    if (portno < 0) {
        error("Invalid port number!\n");
        exit(0);
    }
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        error("ERROR opening socket");
        exit(0);
    }
    my_str("opening socket success\n");
    
    server = gethostbyname(argv[1]);//deprecated. get host name given string
    if (server == NULL) {
        error("ERROR, no such host\n");
        exit(0);
    }
    my_str("host successfully found\n");
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    /*bcopy((char *)server->h_addr, //use memcopy instead
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);*/
    memcpy(&serv_addr.sin_addr.s_addr, (server->h_addr), server->h_length);
    serv_addr.sin_port = htons(portno);
    if (connect(sockfd,(struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
        error("ERROR connecting to server");
        exit(0);
    }
    my_str("Connected to server successfully!\n");
    if (write(sockfd, username, my_strlen(username)) < 0){
        error("ERROR writing");
        exit(0);
    }
    FD_SET(sockfd, &master);
    FD_SET(0, &master);
    while (1) {
        readfds = master;
        if (select(sockfd+1, &readfds, NULL, NULL, NULL) < 0) {
            error("ERROR selecting");
            exit(0);
        }
        if (FD_ISSET(0, &readfds)){
            n = read(0, buffer, MAX_BUFFER_SIZE - 1);
            if (n < 0) {
                error("ERROR reading");
                exit(0);
            }
            buffer[n-1] = '\0';
            //CHECK TO SEE IF USER TYPES '/exit'
            if (my_strcmp(buffer, "/exit") == 0) {
                my_str("Disconnected\n");
                close(sockfd);
                exit(0);
            }
            else {
                if (write(sockfd, buffer, my_strlen(buffer))< 0){
                    error("ERROR writing");
                    exit(0);
                }
            }
        }
        if (FD_ISSET(sockfd, &readfds)) {
            n = read(sockfd, buffer, MAX_BUFFER_SIZE - 1);
            if (n < 0) {
                error("ERROR reading");
                exit(0);
            }
            if (n == 0) {
                my_str("Disconnected\n");
                close(sockfd);
                exit(0);
            }
            else {
                buffer[n] = '\0';
                my_str(buffer);
            }
        }
    }
    return 0; 
    
    /*printf("Please enter the message: ");
    bzero(buffer,256);
    fgets(buffer,255,stdin);
    n = write(sockfd,buffer,strlen(buffer));
    if (n < 0) 
         error("ERROR writing to socket");
    bzero(buffer,256);
    n = read(sockfd,buffer,255);
    if (n < 0) 
         error("ERROR reading from socket");
    printf("%s\n",buffer);
    close(sockfd);
    return 0;*/
}
