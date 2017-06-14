config=YAML.load_file('config/deploy.yml')

servers = [

]

nf = [

]

password = "#{config["deploy"]["password"]}"

role :app, servers, password: password
role :nf, nf, password: password
