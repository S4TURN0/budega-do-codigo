import ipaddress
import csv

def check_ip_in_cidr(ip, cidr_list):
    try:
        ip_obj = ipaddress.IPv4Address(ip)
    except ipaddress.AddressValueError:
        return False  # Ignore endereços invalidos

    for cidr in cidr_list:
        if ip_obj in ipaddress.IPv4Network(cidr, strict=False):
            return True
    return False

def read_csv(file_path,ip_field):
    with open(file_path, 'r') as file:
        reader = csv.DictReader(file)
        ip_addresses = [row[ip_field] for row in reader]
    return ip_addresses


def filter_ips_by_cidr(ip_list, cidr_list):
    filtered_ips = []
    for ip in ip_list:
        if check_ip_in_cidr(ip, cidr_list):
            filtered_ips.append(ip)
    return filtered_ips

def filter_csv_by_ips(input_file_path, output_file_path, cidr_list,ip_field):
    with open(input_file_path, 'r') as input_file, open(output_file_path, 'w', newline='') as output_file:
        reader = csv.DictReader(input_file)
        fieldnames = reader.fieldnames

        # Assumindo que os endereços estão na coluna especificada
        filtered_rows = [row for row in reader if row[ip_field] in cidr_list]

        writer = csv.DictWriter(output_file, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(filtered_rows)

# Início da execução
if __name__ == "__main__":

    # Modifique 'your_cidr_list.txt' com o caminho do seu arquivo CIDR
    with open('your_cidr_list.txt', 'r') as cidr_file:
        cidr_list = [line.strip() for line in cidr_file]

    # Modifique 'your_input_ips.csv' e 'filtered_output.csv' para os nomes de arquivos a serem utilizados
    input_file_path = 'your_input_ips.csv'
    output_file_path = 'filtered_output2.csv'
    
    # Modifique esta variável para o campo correspondente na planilha
    ip_field = "src_ip"

    # Filtre os IPs baseados na lista CIDR
    filtered_ips = filter_ips_by_cidr(read_csv(input_file_path,ip_field), cidr_list)

    # Filtre o CSV e crie um novo CSV com os endereços correspondentes
    filter_csv_by_ips(input_file_path, output_file_path, filtered_ips,ip_field)

    print("O Arquivo CSV filtrado foi criado:", output_file_path)