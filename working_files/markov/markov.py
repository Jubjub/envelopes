import random

markov = {}

previous = None

with open('travel.txt') as data:
    groups = []
    previous_word = None
    #whitelist = set('abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ.')
    #data = ''.join(filter(whitelist.__contains__, data.read()))
    data = data.read().lower()
    for word in data.split():
        if not previous_word:
            previous_word = word
            continue
        word = word.lower()
        groups.append('%s %s' % (previous_word, word))
        previous_word = word

    for word in groups:
        if word in markov:
            item = markov[word]
        else:
            item = {'word': word, 'following': {}, 'previous': {}}
            markov[word] = item
        if not previous:
            previous = item
            continue
        following = item['following']
        following[previous['word']] = following.get(previous['word'], 0) + 1
        previous = item

for key, value in markov.items():
    total = 0
    for a, count in value['following'].items():
        total += count
    for k, v in value['following'].items():
        value['following'][k] /= total

def generate(length):
    #print(markov)
    first_word = 'the'
    last_word = None
    initial = []
    for key, value in markov.items():
        if key.startswith(first_word):
            initial.append(key)
    last_word = random.choice(initial)
    words = [last_word]
    for i in range(0, length):
        rand = random.uniform(0, 1)
        for k, v in markov[last_word]['following'].items():
            #print(markov[last_word])
            rand -= v
            if rand <= 0:
                words.append(k)
                last_word = k
                break
            else:
                print('nope', last_word)
    return ' '.join(words)

print(generate(15))
#print(markov['the'])
