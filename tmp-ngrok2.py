import os
from pyngrok import ngrok, conf

def main():
    if not os.path.exists('ngrok_data.txt'):
        ngrok_token = input("Enter Ngrok token: ")
        with open('ngrok_data.txt', 'w') as f:
            f.write(ngrok_token)
    else:
        reset_option = input("Ngrok token found! Reset? (y/N/O): ")
        if reset_option.lower() in ['y', 'Y']:
            ngrok_token = input("Enter Ngrok token: ")
            with open('ngrok_data.txt', 'w') as f:
                f.write(ngrok_token)
        else:
            with open('ngrok_data.txt', 'r') as f:
                ngrok_token = f.read().strip()

    srv = ngrok.connect(7865, pyngrok_config=conf.PyngrokConfig(auth_token=ngrok_token), bind_tls=True).public_url
    print(srv)
    
    os.system("python Fooocus/entry_with_update.py --always-high-vram")

if __name__ == "__main__":
    main()
