import csv
import json
import markovify

text = ""
with open('movie_lines.tsv') as tsv:
    reader = csv.reader(tsv, delimiter='\t')
    for row in reader:
        if len(row) == 1:
            row = row[0].split('\t')
        text += '%s ' % row[4]

text = open('commies.txt').read()

# Build the model.
print('training model...')
text_model = markovify.Text(text, retain_original=False, state_size=3)
"""
print('cleaning up json...')
with open('../../model.json', 'w') as out:
    data = json.loads(json.loads(text_model.to_json())['chain'])
    for i in range(len(data)):
        item = data[i]
        data[i] = [item[0], [sum(item[1].values()), item[1]]]
        
    out.write(json.dumps(data))

"""
# Print five randomly-generated sentences
for i in range(20):
    print(text_model.make_sentence(test_output=False))

# Print three randomly-generated sentences of no more than 140 characters
#for i in range(5):
#    print(text_model.make_short_sentence(max_chars=2000, min_chars=1000, test_output=False, tries=1000))

