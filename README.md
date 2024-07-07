The Task:
1. You are required to deploy the following voting app into your local K8S cluster:
https://github.com/dockersamples/example-voting-app - **DONE**
2. The application has several components as described in the diagram in the repo, please
use any type of local or managed K8S service-based service to host each of the components. - **DONE**

3. Prepare IAC code (dry run) (terraform plan) to deploy EKS/AKS or local (for example Minikube cluster) and other resources, please take into consideration the following requirements:
   * a. Networking - You can rely on the default resources and other default networking components. - **N/A because of minikube**
   * b. Security - make sure all the applications allow only the necessary access by creating the relevant security groups/firewall rules (i.e., allow access only for the relevant IPs and ports). - **N/A because of minikube. I skiped kubernetes netwrok policies**.
   * c. Load Balancer (optional) – By your choice to receive the external traffic where it makes sense. You can choose your own port / or use the default of 443 (Don’t worry about certificates). - **N/A because of minikube. There is an option to use MetalLB**.
   * d. Scaling - Voting component can have peaks in traffic during the week, please design (not required to implement) auto scalable architecture based on the most relevant metric. - **DONE with HPA**.

 4. Explain how you would handle this differently in a production context in the cloud, please prepare simple diagram.
 In prod I will use for cloud:

 - different AZ, diffecrent subnets for LB, EKS-nodes and DB\Redis.
 - security groups and NACL.
 - IAM and service account.
 - remote secrets.
 - RDS for DB and elasticache for redis.
 - diffecrent accounts for prod.
 - monitoring and logging tools.

In prod I will use for kubernetes:
- ingress controller
- certificate-manager
- external-domain controller
- external-secret operator
- ArgoCd for gitops
- one deployment replica per node
- affinity rules
- health probes

**As you can see, there is no any possibility to create a simple diagramm. I skipped it.**

| Bonus
 Create a basic CI/CD flow for your application, you can use any type of tool to build and deploy.

Notes
 Answer should contain: Terraform files, Helm charts
for the creation of infrastructure (if not all requirements are solvable by terraform - Please describe the additional steps to deploy).
 Cloud provider account is optional - expense won’t be provided.
