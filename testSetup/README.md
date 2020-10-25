Linux Project Deel 1

Automatiseren van Nomad en Conusl aan de van scripting.

Maxim en ik hebben samen gewerkt via het programma Microsoft Teams. Maxim deelde zijn scherm en ik keek mee. Dit aspect komt vaak voor in het programmeren en noemt pair programming.

Ik dacht en hielp mee aan het scripting proces. Als we foutmeldingen kregen of iets lukte niet raadpleegden we het internet. 

Aan de hand van het commando "vagrant up --provision" worden er 3 virtuele machines opgezet. Eéntje hiervan is een nomad server en de andere twee zijn nomad clients. 

Het installscript.sh-script bevat de installaties van Nomad, Consul en Docker.

De andere drie scripts bevatten de configuraties van Nomad en Consul. 

In de Vagrantfile maken we drie centOS7 virtuele machines met de juiste ip adressen waarop de scripts worden uitgevoerd.

Daarnaast hebben we ook een webserver job aangemaakt die automatisch op de cluster draait.

We hebben het best moeilijk gehad met het automatisch toevoegen van de clients aan de nomad server.

Als we het commando "nomad node status" ingaven zagen we dat de clients niet toegevoegd werden. Hierbij hebben we heel wat troubleshoot werk gehad.

Bronnen:

Eigen documentatie (naslagwerk)

https://www.nomadproject.io/docs/configuration

https://learn.hashicorp.com/collections/nomad/manage-jobs

https://sanderknape.com/2016/08/nomad-consul-multi-datacenter-container-orchestration/

https://learn.hashicorp.com/tutorials/nomad/clustering

https://stackoverflow.com/questions/11245144/replace-whole-line-containing-a-string-using-sed

https://stackoverflow.com/questions/2953081/how-can-i-write-a-heredoc-to-a-file-in-bash-script

https://www.nomadproject.io/docs