import boto3
import time
import paramiko
import os

# параметры создаваемого инстанса
instance_type = 't3.micro'
key_name = 'web-dev-key'  # ключ, который ранее создан в AWS
ami_id = 'ami-075449515af5df0d1'  # АМИшка с нашей ОС 
region = 'eu-north-1'  # регион, без него не может создать инстанс

# создание машины
ec2 = boto3.resource('ec2', region_name=region)

instance = ec2.create_instances(
    ImageId=ami_id,
    MinCount=1,
    MaxCount=1,
    InstanceType=instance_type,
    KeyName=key_name
)[0]

print(f'Создание машины с ID: {instance.id}')
instance.wait_until_running()  # ждем пока инстанс запустится
instance.load()  # загружаем информацию о инстансе

# собираем инфу по машине
print(f"IP адрес: {instance.public_ip_address}")
print(f"ОС: {instance.image.id}")
print(f"Тип: {instance.instance_type}")
print(f"Размер диска: {instance.block_device_mappings}")

# Получение метрик 
time.sleep(30)
client = boto3.client('cloudwatch', region_name=region)
metrics = client.list_metrics(Dimensions=[{'Name': 'InstanceId', 'Value': instance.id}])
print("Метрики:")
for metric in metrics['Metrics']:
    print(metric)

# указываем пути к ключам
public_key_file = os.path.expanduser('~/.ssh/id_rsa.pub')  # путь к нашему публичному ключу, который закинем на инстанс
existing_key_file = os.path.expanduser('~/.ssh/web-dev-key.pem')  # путь к ключу, который создан AWS

# создание клиента для ssh подключения
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# подключаемся к машине
ssh.connect(instance.public_ip_address, username='ubuntu', key_filename=existing_key_file)

# из файла записываем в переменную ключик
with open(public_key_file, 'r') as f:
    new_public_key = f.read().strip()

# закидываем ключ в файл authorized_keys на инстанс
ssh.exec_command(f'echo "{new_public_key}" >> ~/.ssh/authorized_keys')
ssh.exec_command('chmod 600 ~/.ssh/authorized_keys')

print("Новый публичный ключ добавлен в authorized_keys на удалённой машине.")
ssh.close()


# удаляем машину
instance.terminate()
print(f'Уничтожение машины с ID: {instance.id}')
instance.wait_until_terminated()  # Ждем, пока инстанс завершится

print('Машина была успешно уничтожена.')