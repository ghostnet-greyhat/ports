import socket

target = input("Ingresa la dirección IP del objetivo: ")
start_port = int(input("Ingresa el puerto de inicio: "))
end_port = int(input("Ingresa el puerto final: "))

for port in range(start_port, end_port+1):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(1)

    result = s.connect_ex((target, port))
    if result == 0:
        print(f"El puerto {port} está abierto.")

        banner = s.recv(1024)
        if banner:
            print(f"Servicio encontrado en el puerto {port}: {banner.decode().strip()}")
    s.close()
