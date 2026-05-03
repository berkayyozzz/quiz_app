import re
import os

tyt_options_map = {
    "Sürtünmesiz yatay düzlemde": [
        "F/m", "m/F", "F.t", "F.t/m", "m/(F.t)"
    ],
    "Sanatçı eserlerinde hayatın gerçeklerini": [
        "Olanı olduğu gibi aktarması", "Hayal gücünü kullanması", "Okura yol göstermesi", "Kendi duygularını katması", "Geçmişi sorgulaması"
    ],
    "a.b = 24 olduğuna göre": [
        "10", "11", "14", "25", "8"
    ],
    "Tarih boyunca birçok medeniyet Mezopotamya": [
        "İklim ve coğrafi şartların elverişli olduğu", "Sürekli savaşların yaşandığı", "Sadece tarımla uğraşıldığı", "İlk yazının burada bulunduğu", "Tek tanrılı dinlerin yaygın olduğu"
    ]
}

ayt_options_map = {
    "Düzgün manyetik alan içerisindeki": [
        "Sağ el kuralı ile bulunur", "Akımla aynı yöndedir", "Manyetik alanla aynı yöndedir", "Tele paraleldir", "Sola doğrudur"
    ],
    "NaOH çözeltisinin pH": [
        "13", "1", "7", "14", "10"
    ],
    "Oksijenli solunum ve laktik asit": [
        "Glikoliz evresi", "Mitokondride gerçekleşmesi", "Oksijen kullanılması", "Laktik asit oluşumu", "Su açığa çıkması"
    ],
    "Kapıkulu askerlerinin üç ayda bir": [
        "Ulufe", "Cülus", "Ganimet", "İkta", "Cizye"
    ],
    "Türkiye\\'nin matematik konumunun": [
        "Maden çeşitliliğinin fazla olması", "Kuzeye gidildikçe gölge boyunun uzaması", "Güneyden esen rüzgarların sıcaklığı artırması", "Dört mevsimin belirgin yaşanması", "Dağların güney yamaçlarının daha sıcak olması"
    ],
    "tecahül-i arif": [
        "Şakaklarıma kar mı yağdı ne var?", "Gül hasretinle yollara tutsun kulağını", "Aslanlarımız bugün destan yazdı", "Bir ah çeksem dağı taşı eritir", "Kömür gözlüm sana doyamadım"
    ],
    "P(x) polinomunun (x-2)": [
        "x+3", "2x-1", "x-3", "2x+1", "x+2"
    ]
}

def get_options(question_text, correct_index, options_map):
    pool = None
    for key, opts in options_map.items():
        # Because question text in python might have literal backslashes if read from file as raw, we just check simple string match
        key_clean = key.replace("\\'", "'")
        qt_clean = question_text.replace("\\'", "'")
        
        if key_clean in qt_clean:
            pool = opts
            break
            
    if pool is None:
        return None
        
    correct_ans = pool[0]
    wrong_ans = pool[1:]
    
    res = [""] * 5
    res[correct_index] = correct_ans
    
    wrong_idx = 0
    for i in range(5):
        if i != correct_index:
            res[i] = wrong_ans[wrong_idx]
            wrong_idx += 1
            
    return res

def process_file(filepath, options_map):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    pattern = re.compile(r'(Question\([^)]+questionText:\s*\"(.*?)\"[^)]+options:\s*\[(.*?)\],\s*correctIndex:\s*(\d+)\s*\))', re.DOTALL)
    
    def repl(match):
        full_match = match.group(1)
        question_text = match.group(2)
        options_str = match.group(3)
        correct_index = int(match.group(4))
        
        new_opts = get_options(question_text, correct_index, options_map)
        
        if new_opts:
            # Reconstruct the array string
            new_opts_str = ", ".join(f"'{opt}'" for opt in new_opts)
            # Find exactly where options array is and replace
            return full_match.replace(f"[{options_str}]", f"[{new_opts_str}]")
            
        return full_match

    new_content = pattern.sub(repl, content)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)

base_dir = r"c:\Users\berka\qq\quiz_app\lib\data"
tyt_path = os.path.join(base_dir, "tyt_new_questions_7.dart")
ayt_path = os.path.join(base_dir, "ayt_new_questions_7.dart")

process_file(tyt_path, tyt_options_map)
process_file(ayt_path, ayt_options_map)
print("Done")
