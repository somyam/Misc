#include "split.h"
#include <string.h>

void *CS61C_malloc(size_t size);
void CS61C_free(void *ptr);

/*
For reference, this is the Node struct defined in split.h:
typedef struct node {
  char *data;
  struct node *next;
} Node;
*/
void split(Node *words, Node **consonants, Node **vowels) {
	//YOUR CODE HERE
  Node *currConsonants = *consonants;
  Node *currvowels = *vowels;
  while(words) {
    char *curr = CS61C_malloc(strlen(words->data) + 1);
    if (curr) {
      strcopy(curr, words->data); //copy data into curr
      CS61C_free(words->data); //free old data
      Node *new = CS61C_malloc(sizeof(Node)); //make a new node
      if (new != NULL) {
        new->data = curr; //put shit in new node
        char last = new[strlen(curr) - 1]; //get the last character in curr excluding \0
        if (last != 'a' && last != 'e' && last != 'i' && last != 'o' && last != 'u') { //if we are a consonant
          if(currConsonants == NULL) {
            currConsonants = new; //add new node to new consonant list
          } else {
            currConsonants->next = new; //add new node to existing list
            currConsonants = currConsonants->next;
          }
        } else {
          if(currvowels == NULL) {
            currvowels = new; //add new node to new vowel list
            } else {
              currvowels->next = new; //add new node to existing consonant list
              currvowels = currvowels->next;
            }
        }
        Node *temp = words; //save the current head
        words = temp->next; //move pointer along
        CS61C_free(temp); //free that pointer
      }
    }
  }
  return;
}
