Kubernetes setup and deployment in GCloud
=========================================


whith this setup you will be able to configure a Kubernetes cluster  in Googoe Cloud and install Go CD.

Prerequisites
--------------

You'll need this tools installed and configurated to acomplish this task

1. [Kubernetes => v.1.7.5](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
2. [Terraform  => v.0.10.8](https://www.terraform.io/)
3. [Google Cloud SDK => 190.0.1](https://cloud.google.com/sdk/)
4. A [Google Cloud account](https://cloud.google.com/)
5. A project created on Google Cloud.
6. Change the project name used for your own project name. 
7. Download the connection json file from Google Cloud that you can see how to generate in [Json generation file](https://www.terraform.io/docs/providers/google/index.html#authentication-json-file) 
8. Create a `user.txt` file and a `password.txt` file in the ROOT folder to configure the access to the cluster. This user and password will be encrypted later by kubernetes.

    Example for `user.txt`
        
        user_admin

Steps to depoy this recipe
---------------------------

1. Connect to the Google Cloud  `gcloud init` and set values from your account and project.
2. From the project folder execute `terraform init` to initialize terraform and download the dependencies.
3. Execute `terraform plan` to generate and show an execution plan.
4. Execute `terraform apply` to execute the deploy on Google Cloud.
5. After this execution you'll need to execute a bash script located in the project folder `./kube.sh`.
6. Verify the Expose Ip that shows the execution of the last command and then you could access to [Go CD](https://www.gocd.org/). If it doesn't shows the IP execute `kubectl get services` and use the exposed IP from `my-loadbalancer`.
7. Once you have the exposed IP edit the file `scripts/pipeline.py` and chage the IP that appear in the file by the new exposed IP and then, from the pipeline directory execute `python pipeline.py` to deploy the pipeline on the server.
8. Using the GoCD GUI enable the agent and create a new Environment, on the Environment creation add the pipeline and the agent to it, so the pipeline could be tested.
9. If you want to destroy the Infrastructure execute `terraform destroy`


# More Information?

* My [mail](mailto:andres.torresduran@gmail.com)
* My [GitLab account](https://gitlab.com/aetorres)
* My [Bitbucket account](https://bitbucket.org/aetorres/)
* My [GitLab account](https://github.com/aetorres)
* My [Twitter](https://twitter.com/Andr3s_T)

