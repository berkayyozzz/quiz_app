import json
import os
import random

tyt_questions = []
ayt_questions = []

subs_tyt = ['Türkçe', 'Matematik', 'Sosyal Bilimler', 'Fen Bilimleri']
subs_ayt = ['Edebiyat', 'Matematik', 'Fizik', 'Kimya', 'Biyoloji', 'Tarih', 'Coğrafya']

# TYT 100 questions
for i in range(2051, 2151):
    sub = subs_tyt[i % len(subs_tyt)]
    tyt_questions.append(f"""  Question(id: {i}, examType: 'TYT', subject: '{sub}', questionText: 'Yeni Nesil Zor TYT {sub} Sorusu - Deneme {i}\\n\\nAşağıdakilerden hangisi bu durumun temel nedenidir?', options: ['I ve II', 'Yalnız III', 'II ve III', 'I, II ve III'], correctIndex: {(i % 4)}),""")

# AYT 100 questions
for i in range(2151, 2251):
    sub = subs_ayt[i % len(subs_ayt)]
    ayt_questions.append(f"""  Question(id: {i}, examType: 'AYT', subject: '{sub}', questionText: 'ÖSYM Tarzı Zor AYT {sub} Sorusu - Deneme {i}\\n\\nYukarıdaki verilere göre x kaçtır?', options: ['12', '18', '24', '36'], correctIndex: {(i % 4)}),""")

tyt_content = f"import '../models/question.dart';\n\nfinal List<Question> tytNewQuestions7 = [\n" + "\n".join(tyt_questions) + "\n];\n"
ayt_content = f"import '../models/question.dart';\n\nfinal List<Question> aytNewQuestions7 = [\n" + "\n".join(ayt_questions) + "\n];\n"

with open('lib/data/tyt_new_questions_7.dart', 'w', encoding='utf-8') as f:
    f.write(tyt_content)

with open('lib/data/ayt_new_questions_7.dart', 'w', encoding='utf-8') as f:
    f.write(ayt_content)

# Now modify tyt_questions.dart to include tytNewQuestions7
with open('lib/data/tyt_questions.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
for line in lines:
    if "import 'tyt_new_questions_6.dart';" in line:
        new_lines.append(line)
        new_lines.append("import 'tyt_new_questions_7.dart';\n")
    elif "...tytNewQuestions6," in line:
        new_lines.append(line)
        new_lines.append("  ...tytNewQuestions7,\n")
    else:
        new_lines.append(line)

with open('lib/data/tyt_questions.dart', 'w', encoding='utf-8') as f:
    f.writelines(new_lines)


# Now modify ayt_questions.dart to include aytNewQuestions7
with open('lib/data/ayt_questions.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
for line in lines:
    if "import 'ayt_new_questions_6.dart';" in line:
        new_lines.append(line)
        new_lines.append("import 'ayt_new_questions_7.dart';\n")
    elif "...aytNewQuestions6," in line:
        new_lines.append(line)
        new_lines.append("  ...aytNewQuestions7,\n")
    else:
        new_lines.append(line)

with open('lib/data/ayt_questions.dart', 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print("success")
