  #include <stdio.h> 
  #include "my.h"
  int main(){ 
	
  /*char a[] = "a";
  char ab[] = "ab";
  char abc[] = "abc";*/

  char *input1;
  char *abcs;
  char *inputcpy;
  
  my_str(""); /*prints nothing*/
  my_str(NULL); /*prints nothing*/
  my_str("Hello");
  my_str(" World!\n");
  /*my_char('\n');
  printf("%i\n", my_strlen(a)); 
  printf("%i\n", my_strlen(""));
  printf("%i\n", my_strlen(NULL));
  printf("%i\n", my_strlen(ab));
  printf("%i\n", my_strlen(abc));
  my_str(a);
  printf(" %i\n", my_revstr(a));
  my_str(ab);
  printf(" %i\n", my_revstr(ab));
  my_str(abc);
  printf(" %i\n", my_revstr(abc));
  printf(" %i\n", my_revstr(NULL)); 
  my_alpha();*/

 /*HW2 TEST CASES
  my_char('\n');
  my_num_base(4, "a");
  my_char('\n');
  my_num_base(9, "RTFM");
  my_char('\n');
  my_num_base(-1, "ABC");
  my_num_base(-2147483648, "RTFM");

  my_char('\n');*/

  /*printf("%i\n", my_strindex("catamaran", 'r'));
  printf("%i\n", my_strindex("apple", 'p'));
  printf("%i\n", my_strindex("abcdefghijklmnopqrstuvwxyz", 'u'));
  printf("%i\n", my_strindex("aaaaaaaaa", 'b'));
  printf("%i\n", my_strindex("", 'z'));

  printf("%i\n", my_strrindex("catamaran", 'r'));
  printf("%i\n", my_strrindex("apple", 'p'));
  printf("%i\n", my_strrindex("abcdefghijklmnopqrstuvwxyz", 'u'));
  printf("%i\n", my_strrindex("aaaaaaaaa", 'b'));
  printf("%i\n", my_strrindex("", 'z'));

  printf("%s\n", my_strfind("apple", 'p'));
  printf("%s\n", my_strfind("abcdefghijklmnopqrstuvwxyz", 'u'));
  printf("%s\n", my_strfind("aaaaaaaaaaa", 'z'));
  printf("%s\n", my_strfind("", 'z'));

  printf("%s\n", my_strrfind("apple", 'p'));
  printf("%s\n", my_strrfind("abcdefghijklmnopqrstuvwxyz", 'u'));
  printf("%s\n", my_strrfind("aaaaaaaaaaa", 'z'));
  printf("%s\n", my_strrfind("status", 's'));

  printf("%i\n", my_strcmp("s", "s"));
  printf("%i\n", my_strcmp("s", "a"));
  printf("%i\n", my_strcmp("HELLO", NULL));
  printf("%i\n", my_strcmp(NULL, NULL));
  printf("%i\n", my_strcmp("", NULL));
//  printf("%s\n", "Check hurrr");
  printf("%i\n", my_strcmp(my_strnconcat("abc","def", 1),"\0"));

  printf("%i\n", my_strncmp("HELLO", NULL, 2));
  printf("%i\n", my_strncmp(NULL, NULL, 0));
  printf("%i\n", my_strncmp("HELLO", "HELLO", -5));
  printf("%i\n", my_strncmp("HELLO", "HELLOWORLD", 30));
  printf("%i\n", my_strncmp("HELLOWORLD", "HELLO", 8));
  printf("%i\n", my_strncmp("", "BANANA", 2));
  printf("%i\n", my_strncmp("", NULL, 3));
*/
  printf("%s\n", "my_strcpy test cases");
  if (my_strcpy(NULL, "HELLO") == NULL) printf("NULL\n");
  if (my_strcpy(NULL, NULL) == NULL) printf("NULL\n");
  inputcpy = malloc(my_strlen("abcdef") + my_strlen("zyxwvut") + 1);
  inputcpy[0] = 'a';
  inputcpy[1] = 'b';
  inputcpy[2] = 'c';
  inputcpy[3] = 'd';
  inputcpy[4] = 'e';
  inputcpy[5] = 'f';
  printf("%s\n", my_strcpy(inputcpy,"zyxt"));
  printf("%s\n", my_strcpy("", NULL));
  abcs = malloc(27);
  abcs[0] = 'a';
  abcs[1] = 'b';
  abcs[2] = 'c';
  abcs[3] = 'd';
  abcs[4] = 'e';
  abcs[5] = 'f';
  abcs[6] = 'g';
  abcs[7] = 'h';
  abcs[8] = 'i';
  abcs[9] = 'j';
  abcs[10] = 'k';
  printf("%s\n", my_strcpy(abcs,"aaaaa"));
  printf("%s\n", my_strcpy(abcs,"abc"));
  printf("%s\n", my_strcpy(abcs,"ban"));
  printf("%s\n", my_strcpy(NULL, "HELLO"));

  printf("%s\n", "my_strncpy test cases");
  printf("%s\n", my_strncpy(inputcpy,"zyxwvutsrquv", 7));
  printf("%s\n", my_strncpy(NULL, "HELLO", 3));
  printf("%s\n", my_strncpy(NULL,"", '\0'));
  printf("%s\n", my_strncpy(abcs,"aaaaaaaaaaaa", 5));
  printf("%s\n", my_strncpy(abcs,"", -1));
  printf("%s\n", my_strncpy(abcs,"abc", 8));
  printf("%s\n", my_strncpy(abcs,"banana", 3));

  input1 = malloc(my_strlen("candy") *2 + 1);
  input1[0]='c';
  input1[1]='a';
  input1[2]='n';
  input1[3]='d';
  input1[4]='y';
  printf("%s\n", my_strcat(input1,"apple"));
 /* printf("%s\n", my_strcat("abcdefghijkl","zyx"));
  printf("%s\n", my_strcat("ellen","catherine"));
  printf("%s\n", my_strcat("zyxwvut",""));
  printf("%s\n", my_strcat("","zyxwvut"));*/

  printf("%s\n", my_strdup("apple"));
  printf("%s\n", my_strdup(""));
  printf("%s\n", my_strdup("string"));
  printf("%s\n", my_strdup("abccba"));
  printf("%s\n", my_strdup("a"));

  printf("%s\n", my_strconcat("abc","def"));
  printf("%s\n", my_strconcat("abc",""));
  printf("%s\n", my_strconcat("","def"));
  printf("%s\n", my_strconcat("",""));
  printf("%s\n", my_strconcat("apple","banana"));

  printf("%s\n", "Check hurrr");
  printf("%s\n", my_strnconcat("abc","def", 1));
  printf("%s\n", my_strnconcat("abc","", 2));
  printf("%s\n", my_strnconcat("","def", 1));
  printf("%s\n", my_strnconcat("","", 3));
  printf("%s\n", my_strnconcat("apple","banana", 3));

  my_num_base(-10, "01");

  /*printf("%i\n", my_atoi("5"));
  printf("%i\n", my_atoi("-5"));
  printf("%i\n", my_atoi("--5"));
  printf("%i\n", my_atoi("a-b54sc7-d"));
  printf("%i\n", my_atoi("abcd"));
  printf("%i\n", my_atoi("a-b-54sc85-ed"));
  printf("%i\n", my_atoi(NULL));
  printf("%i\n", my_atoi(""));
  printf("%i\n", my_atoi("0000"));

  printf("%s\n", my_strnconcat(NULL,"World",-5));
  printf("%i\n", my_atoi("-abcdefg"));
  printf("%i\n", my_atoi("ax-wcdsx--sdfs420fsdv30"));*/


  my_char('\n');
  return 0;
}
