import json
import os

tyt_questions = []
ayt_questions = []

subs_tyt = ['Türkçe', 'Matematik', 'Sosyal Bilimler', 'Fen Bilimleri']
subs_ayt = ['Edebiyat', 'Matematik', 'Fizik', 'Kimya', 'Biyoloji', 'Tarih', 'Coğrafya']

for i in range(1051, 1101):
    sub = subs_tyt[i % len(subs_tyt)]
    tyt_questions.append(f"""  Question(id: {i}, examType: 'TYT', subject: '{sub}', questionText: 'Bu soru TYT {sub} alanında hazırlanmış örnek bir sorudur. Soru içeriği numarası: {i}?', options: ['Seçenek A', 'Seçenek B', 'Seçenek C', 'Seçenek D', 'Seçenek E'], correctIndex: {(i % 5)}),""")

for i in range(1051, 1101):
    sub = subs_ayt[i % len(subs_ayt)]
    ayt_questions.append(f"""  Question(id: {i}, examType: 'AYT', subject: '{sub}', questionText: 'Bu soru AYT {sub} alanında hazırlanmış örnek bir sorudur. Soru içeriği numarası: {i}?', options: ['Seçenek A', 'Seçenek B', 'Seçenek C', 'Seçenek D', 'Seçenek E'], correctIndex: {(i % 5)}),""")

tyt_content = f"import '../models/question.dart';\n\nfinal List<Question> tytNewQuestions6 = [\n" + "\n".join(tyt_questions) + "\n];\n"
ayt_content = f"import '../models/question.dart';\n\nfinal List<Question> aytNewQuestions6 = [\n" + "\n".join(ayt_questions) + "\n];\n"

with open('lib/data/tyt_new_questions_6.dart', 'w', encoding='utf-8') as f:
    f.write(tyt_content)

with open('lib/data/ayt_new_questions_6.dart', 'w', encoding='utf-8') as f:
    f.write(ayt_content)

# Now modify tyt_questions.dart to include tytNewQuestions6
with open('lib/data/tyt_questions.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
for line in lines:
    if "import 'tyt_new_questions_5.dart';" in line:
        new_lines.append(line)
        new_lines.append("import 'tyt_new_questions_6.dart';\n")
    elif "...tytNewQuestions5," in line:
        new_lines.append(line)
        new_lines.append("  ...tytNewQuestions6,\n")
    else:
        new_lines.append(line)

with open('lib/data/tyt_questions.dart', 'w', encoding='utf-8') as f:
    f.writelines(new_lines)


# Now modify ayt_questions.dart to include aytNewQuestions6
with open('lib/data/ayt_questions.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
for line in lines:
    if "import 'ayt_new_questions_5.dart';" in line:
        new_lines.append(line)
        new_lines.append("import 'ayt_new_questions_6.dart';\n")
    elif "...aytNewQuestions5," in line:
        new_lines.append(line)
        new_lines.append("  ...aytNewQuestions6,\n")
    else:
        new_lines.append(line)

with open('lib/data/ayt_questions.dart', 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print("success")
