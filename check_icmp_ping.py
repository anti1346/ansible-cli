import sys
import subprocess
import ipaddress

def ping(host):
    """
    주어진 호스트에 대한 ping을 수행하고 결과를 반환합니다.
    """
    try:
        # 플랫폼에 따라 ping 명령어의 형식이 다를 수 있습니다.
        subprocess.run(["ping", "-c", "1", "-W", "1", host], stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
        return 0  # 성공
    except subprocess.CalledProcessError:
        return 1  # 실패

def main(subnet_input):
    try:
        # 입력받은 서브넷을 이용하여 네트워크 주소 추출
        network = ipaddress.IPv4Network(subnet_input, strict=False)
    except ValueError as e:
        print(f"Error: {e}")
        return

    # ping 테스트 수행
    for host in network.hosts():
        response = ping(str(host))

        # 응답 확인 및 결과 출력
        if response == 0:
            print(f"{host}\tis reachable")
        # else:
        #     print(f"{host}\tis unreachable")

if __name__ == "__main__":
    # 명령행 인수에서 서브넷을 받아옴
    if len(sys.argv) != 2:
        print("Usage: python check_icmp_ping.py <subnet>")
        sys.exit(1)

    subnet_input = sys.argv[1]
    main(subnet_input)
