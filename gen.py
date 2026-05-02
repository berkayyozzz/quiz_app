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
    if sub == 'Türkçe':
        q_text = "Parçadaki altı çizili sözle anlatılmak istenen aşağıdakilerden hangisidir?\\n\\nSanatçı eserlerinde hayatın gerçeklerini bir ayna gibi yansıtır."
    elif sub == 'Matematik':
        q_text = "a ve b pozitif tam sayılar olmak üzere, a.b = 24 olduğuna göre a+b toplamının alabileceği en küçük değer kaçtır?"
    elif sub == 'Sosyal Bilimler':
        q_text = "Bu duruma bakarak aşağıdakilerden hangisine ulaşılabilir?\\n\\nTarih boyunca birçok medeniyet Mezopotamya bölgesinde kurulmuştur."
    else:
        q_text = "Sürtünmesiz yatay düzlemde duran K cismine F kuvveti t süre uygulanıyor.\\n\\nBuna göre cismin ivmesi kaç m/s² olur?"
    
    tyt_questions.append(f"""  Question(id: {i}, examType: 'TYT', subject: '{sub}', questionText: '{q_text}', options: ['A seçeneği', 'B seçeneği', 'C seçeneği', 'D seçeneği'], correctIndex: {(i % 4)}),""")

# AYT 100 questions
for i in range(2151, 2251):
    sub = subs_ayt[i % len(subs_ayt)]
    if sub == 'Matematik':
        q_text = "P(x) polinomunun (x-2) ile bölümünden kalan 5, (x+1) ile bölümünden kalan 2'dir.\\n\\nBuna göre P(x)'in (x²-x-2) ile bölümünden kalan aşağıdakilerden hangisidir?"
    elif sub == 'Edebiyat':
        q_text = "Aşağıdaki dizelerin hangisinde tecahül-i arif sanatı vardır?"
    elif sub == 'Fizik':
        q_text = "Düzgün manyetik alan içerisindeki iletken telin uzunluğu L, üzerinden geçen akım i'dir.\\n\\nBuna göre tele etki eden manyetik kuvvetin yönü nedir?"
    elif sub == 'Kimya':
        q_text = "Belirli bir sıcaklıkta 0,1 M NaOH çözeltisinin pH değeri kaçtır?"
    elif sub == 'Biyoloji':
        q_text = "Oksijenli solunum ve laktik asit fermantasyonunda aşağıdakilerden hangisi ortaktır?"
    elif sub == 'Tarih':
        q_text = "Osmanlı Devleti'nde Kapıkulu askerlerinin üç ayda bir aldıkları maaşa ne ad verilir?"
    else:
        q_text = "Türkiye'nin matematik konumunun sonuçları arasında aşağıdakilerden hangisi gösterilemez?"
        
    ayt_questions.append(f"""  Question(id: {i}, examType: 'AYT', subject: '{sub}', questionText: '{q_text}', options: ['A seçeneği', 'B seçeneği', 'C seçeneği', 'D seçeneği'], correctIndex: {(i % 4)}),""")

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
