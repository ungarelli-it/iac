# iac

É preciso criar o arquivo terraform.tfvars conforme exemplo:

```
# API Token da Digital Ocean
token             = "123456"
# Nome do cluster kubernetes
cluster_name      = "general"
# Tipo de instancia que será utilizado
node_pool_size    = "s-2vcpu-4gb"
# dominio ao qual o Rancher pertencerá
domain            = "ungarelli.it"
# Endereço de email vinculado ao letsencrypt
admin_mail        = "roberto.ungarelli@gmail.com"
```

## Problema: x509: certificate signed by unknown authority

Correção:
```
kubectl --kubeconfig=kubeconfig patch validatingwebhookconfigurations ingress-nginx-admission -n ingress-nginx --type='json' -p='[{"op": "add", "path": "/webhooks/0/clientConfig/caBundle", "value":"'$(kubectl --kubeconfig=kubeconfig -n ingress-nginx get secret ingress-nginx-admission -ojsonpath='{.data.ca}')'"}]'
```

Obs.: Após a correçao acima, deve executar o pipeline novamente

## Configurar o DNS, para apontar para o IP do LoadBalancer

O IP do LoadBalancer pode ser obtido em https://cloud.digitalocean.com/networking/load_balancers

## Atualização do Ingress do Rancher:

Para que o Rancher esteja acessível e com certificado válido, é preciso editar o ingress com o comando abaixo:

```
kubectl --kubeconfig=kubeconfig -n cattle-system edit ingress rancher
```

E ajustar as anotações, adicionando as 2 primeiras linhas e comentando as 2 linhas finais, conforme abaixo.

```
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt-prod
    #    cert-manager.io/issuer: rancher
    #    cert-manager.io/issuer-kind: Issuer
```
