import os

def count_gd_lines(folder):
    file_num = 0
    total = 0
    for root, dirs, files in os.walk(folder):
        for file in files:
            if file.endswith(".gd"):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    total += sum(1 for _ in f)
                    file_num = file_num +1
    print(f"文件数：{file_num}")
    return total

if __name__ == "__main__":
    folder = input("请输入目录路径：")
    print(f"总代码行数：{count_gd_lines(folder)}")