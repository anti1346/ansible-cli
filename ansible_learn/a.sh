#!/bin/bash

port_numbers=(22 80 6379)

# Function to check version
check_version() {
    server=$1

    if [ -e "$(command -v ${server})" ]; then
        os_name=$(awk -F= '/^NAME/ {print $2}' /etc/os-release | tr -d '"')
        server_name=$(command -v ${server} | awk -F'/' '{print $NF}')
        server_version=$("${server}" -v 2>&1 | grep -oP "\K[0-9]+\.[0-9]+\.[0-9]+")

        echo -e "\n${os_name} - ${server}"
        echo "${server_name}_name=${server_name}"
        echo "${server_name}_version=${server_version}"
    else
        echo "${server} file does not exist"
    fi
}

for port_number in "${port_numbers[@]}"; do
    # ss로 포트를 사용 중인 PID 찾기
    pid_list=$(netstat -tulpn 2>/dev/null | grep "0.0.0.0:$port_number" | awk '{print $7}' | awk -F'/' '{print $1}' | sort -u)

    for pid in $pid_list; do
        # PID로 실행 파일 경로 찾기
        exe_path=$(readlink /proc/"$pid"/exe)

        if [ -n "$exe_path" ]; then
            echo "포트 $port_number를 사용 중인 프로세스의 실행 파일 경로:"
            echo "$exe_path"
            check_version $exe_path
        else
            echo "PID $pid에 대한 실행 파일 경로를 찾을 수 없습니다."
        fi
    done
done
