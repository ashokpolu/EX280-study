oc new-project tls-demo




## Run the following command to create the private key

openssl genrsa -out training.key 4096

## Run the following command to generate a certificate signing request

openssl req -new \
  -subj "/C=US/ST=North Carolina/L=Raleigh/O=Red Hat/CN=todo-https.apps.ocp4.example.com" \
  -key training.key -out training.csr

## Run the following command to generate a certificate

openssl x509 -req -in training.csr \
  -passin file:passphrase.txt \
  -CA training-CA.pem -CAkey training-CA.key -CAcreateserial \
  -out training.crt -days 1825 -sha256 -extfile training.ext
  
Another way
  
openssl genrsa -des3 -out myca.key 2048

openssl req -x509 -new -key myca.key -sha256 -days 3650 -out myca.pem

openssl genrsa -out tls.key 2048

openssl req -new -key tls.key -out tls.csr

openssl x509 -req -in tls.csr -CA myca.pem -CAkey myca.key -CAcreateserial -out tls.crt -days 1650

ca.crt service-ca.crt tls.crt


oc new-app --name=secureapp --image=bitnami/apache

oc get all

oc create route edge --service=secureapp --hostname=secureapp.apps-crc.testingting --cert=tls.crt --key=tls.key

oc create route passthrough --service=secureapp --hostname=secureapp.apps-crc.testingting --cert=tls.crt --key=tls.key

curl -v -k https://secureapp.apps-crc.testing 

oc get routes.route.openshift.io

oc describe route secureapp

oc get route secureapp -o yaml

oc create secret tls apache --cert=tls.crt --key=tls.key

oc get secrets
https://www.youtube.com/watch?v=Pjj4yJA5Bz0&list=PLnFCwVWiQz4nFE9X6ADRTtBvZDIrIAL1u&index=11&t=2s
 
  
  
