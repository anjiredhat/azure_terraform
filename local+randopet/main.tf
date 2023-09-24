resource "random_pet" "petname" {}

resource "local_file" "newfile" {
    filename = "/tmp/anji-${random_pet.petname.id}.txt"
    content = "hello polagoni Anjaneyulu"

}

output "filename" {
    value = local_file.newfile.filename
}