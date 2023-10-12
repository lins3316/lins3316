import cs50

# prompt user to type in some text
text = cs50.get_string("Type in some text:\n")


# calculate the number of letters in the text
def letter_count(parag):
    counter = 0
    for i in range(len(parag)):
        if ord(parag[i]) in range(65, 91, 1) or ord(parag[i]) in range(97, 123, 1):
            counter += 1
    return counter


# calculate the number of words in the text
def word_count(parag):
    counter = 1
    for i in range(len(parag)):
        if ord(parag[i]) == 32:
            counter += 1
    return counter


# calculate the number of sentences in the text
def sent_count(parag):
    counter = 0
    for i in range(len(parag)):
        if ord(parag[i]) in [33, 46, 63]:
            counter += 1
    return counter



# calculate the average number of letters per 100 words "L"
L = (letter_count(text) * 100) / word_count(text)

# calculate the average number of sentences per 100 words "S"
S = (sent_count(text) * 100) / word_count(text)

# index formula
index = 0.0588 * L - 0.296 * S - 15.8
print(letter_count(text))
print(word_count(text))
print(sent_count(text))
print(L)
print(S)
print(index)

if index > 16:
    print("Grade 16+")
elif index < 1:
    print("Before Grade 1")
else:
    print(f"Grade {round(index)}")