provider "google" {
  credentials = "${file("account.json")}"  
  project     = "k8s-gocd3"
  region      = "us-central1"
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "gcloud  services enable container.googleapis.com "   
  
  }
}

resource "google_container_cluster" "primary" {
  name               = "k8s-gocd-cluster"
  zone               = "us-central1-a"
  initial_node_count = 4

  master_auth {
    username = "admin_test"
    password = "s3cr3ts_4ndr3s_t0rr3s"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  addons_config {
    kubernetes_dashboard {
      disabled = false
      }
  }

}

# The following outputs allow authentication and connectivity to the GKE Cluster.
output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}

/*resource "null_resource" "default2" {
    provisioner "local-exec" {
    command = "gcloud container clusters get-credentials k8s-gocd-cluster --zone us-central1-a --project k8s-gocd3"
    command = "helm init"
    command = "helm install --name my-release incubator/gocd"
    command = "kubectl expose deployment my-release-gocd-server --type=LoadBalancer --name=my-loadbalancer"
    command = "kubectl get services"
  }
    depends_on = ["google_container_cluster.primary"]
}
*/