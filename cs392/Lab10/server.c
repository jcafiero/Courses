/* A simple server in the internet domain using TCP
   The port number is passed as an argument */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>

void error(const char *msg)
{
    perror(msg);
    exit(1);
}

int main(int argc, char *argv[])
{
     int sockfd, newsockfd, portno;
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
     return 0; 
}
