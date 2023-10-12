// Implements a dictionary's functionality

#include <ctype.h>
#include <stdbool.h>
#include <strings.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// TODO: Choose number of buckets in hash table
const unsigned int N = 26;

// Other variables
unsigned int hash_value;
unsigned int word_count;

// Hash table
node *table[N];

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // Hash word to obtain hash value
    hash_value = hash(word);

    // Traverse linked list looking for the word (strcasecmp)
    node *cursor = table[hash_value];

    // return true if the word is in the hash table (dictionary)
    while (cursor != 0)
    {
        if (strcasecmp(word, cursor->word) == 0)
        {
            return true;
        }
        cursor = cursor->next;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO: Improve this hash function
    unsigned long ascii_tot = 0;
    unsigned long fin_result = 0;
    for (int incr = 0; incr < strlen(word); incr++)
    {
        ascii_tot += tolower(word[incr]);
    }
    fin_result = ascii_tot % N;
    return fin_result;

    // Credit Hash: https://www.youtube.com/watch?v=wHUpt71YGeY&t=704s
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // Open dictionary
    FILE *dict = fopen(dictionary, "r");

    // check for validity
    if (dict == NULL)
    {
        printf("Unable to open file");
        return false;
    }

    // Declare word variable
    char word[LENGTH + 1];

    // Read string from file one at a time
    while (fscanf(dict, "%s", word) != EOF)
    {
        // Allocate memory for new node
        node *new_node = malloc(sizeof(node));

        // Check for validity
        if (new_node == NULL)
        {
            printf("Space invalid");
            return false;
        }

        // Copy word into the node
        strcpy(new_node->word, word);

        // Hash word to obtain a hash value
        hash_value = hash(word);

        // Insert node into hash table at that location
        new_node->next = table[hash_value];
        table[hash_value] = new_node;

        // keeping track of word count
        word_count++;
    }
    fclose(dict);
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    return word_count;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // Making a loop
    for (int i = 0; i < N; i++)
    {
        // Creating cursor and temp nodes
        node *cursor = table[i];
        node *tmp = cursor;
        while (cursor != NULL)
        {
            cursor = cursor->next;
            free(tmp);
            tmp = cursor;
        }
    }
    return true;
}
