resource "docker_container" "jenkins" {
    name = "Myjenkins"
    image = docker_image.jenkins.image_id
    ports {
        internal = "80"
        external = "9099"
    }
  
}

resource "docker_image" "jenkins" {
    name = "jenkins/jenkins:lts"
  
}