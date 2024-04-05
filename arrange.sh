#!/bin/bash

# 'files' 디렉토리로 이동
cd files

# 현재 디렉토리('./files') 내의 모든 파일에 대하여 반복
for file in *; do
    # 파일이 디렉토리인 경우 건너뛰기
    if [ -d "$file" ]; then
        continue
    fi

    # 파일 이름의 첫 글자를 추출
    first_letter=${file:0:1}

    # 상위 디렉토리로 이동하여 해당하는 알파벳 폴더가 존재하는지 확인 (대소문자 구분 없이)
    folder_found=false
    for folder in ../*/; do
        if [[ ${folder,,} == ../${first_letter,,}*/ ]]; then
            # 폴더가 있으면 파일을 해당 폴더로 이동
            mv "$file" "${folder}"
            folder_found=true
            break
        fi
    done

    if [ "$folder_found" = false ]; then
        # 해당하는 폴더가 없으면 메시지 출력하고 files 폴더로 돌아가기
        echo "[${file}] cannot be arranged"
    fi
done

cd ..
echo "파일 정리 작업 완료."
