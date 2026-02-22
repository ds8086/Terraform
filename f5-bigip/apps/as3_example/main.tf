provider "bigip" {
  address  = var.bigip_hostname
  username = var.bigip_username
  password = var.bigip_password
}

module "web" {
  source = "../../modules/as3"

  app_partition = "as3-example"
  app_protocol  = "http"
  app_port      = 80
  app_ip        = "192.168.200.1"
  app_fqdn      = "example.lab.local"
  app_gtm       = false
  
  app_nodes = [
    {
      "name" : "webserver01",
      "address" : "192.168.100.1"
    },
    {
      "name" : "webserver02",
      "address" : "192.168.100.2"
    }
  ]
}

module "tcp" {
  source = "../../modules/as3"

  app_partition = "as3-example"
  app_protocol  = "tcp"
  app_port      = 42069
  app_ip        = "192.168.200.1"
  app_fqdn      = "example.lab.local"
  app_gtm       = false

  app_nodes = [
    {
      "name" : "webserver01",
      "address" : "192.168.100.1"
    },
    {
      "name" : "webserver02",
      "address" : "192.168.100.2"
    }
  ]
}

module "secure" {
  source = "../../modules/as3"

  app_partition = "as3-example"
  app_protocol  = "https"
  app_port      = 443
  app_ip        = "192.168.200.1"
  app_fqdn      = "example.lab.local"
  app_gtm       = true
  gtm_server    = "gtm"

  app_nodes = [
    {
      "name" : "webserver01",
      "address" : "192.168.100.1"
    },
    {
      "name" : "webserver02",
      "address" : "192.168.100.2"
    }
  ]

  app_cert = "-----BEGIN CERTIFICATE-----\nMIIDmjCCAoKgAwIBAgIEHRgZwDANBgkqhkiG9w0BAQsFADCBjjELMAkGA1UEBhMC\nVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtMb3MgQW5nZWxlczESMBAGA1UEChMJ\nTGFiLCBJbmMuMQ0wCwYDVQQLEwRUZWNoMRowGAYDVQQDExFleGFtcGxlLmxhYi5s\nb2NhbDEdMBsGCSqGSIb3DQEJARYOdGVjaEBsYWIubG9jYWwwHhcNMjUwNjIwMjAz\nMjAwWhcNMjYwNjIwMjAzMjAwWjCBjjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNB\nMRQwEgYDVQQHEwtMb3MgQW5nZWxlczESMBAGA1UEChMJTGFiLCBJbmMuMQ0wCwYD\nVQQLEwRUZWNoMRowGAYDVQQDExFleGFtcGxlLmxhYi5sb2NhbDEdMBsGCSqGSIb3\nDQEJARYOdGVjaEBsYWIubG9jYWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK\nAoIBAQCtvJaa/lg4mIDu4IqmVjEfQWR1vZYWnfKZeGPKdNQA3n7z9Hb/wbO1LFs0\nhrYDkdWIy+TpVAV1TZy2eUEsOD+lLiFqw7E6NTXVupWLuZtHA3vc/sjfAVe4MZ8F\nhKYYMYlQEn0B0zpxNw5ynwIXK7pP+UtKByeyme8dpJL9wb1Ol6aLla6C+IGsENWs\n+AvM7bewlaKsntO5aiUfVAeHqvIKBHn/89b+vDx12wX5CEb2JUCZM6b+nYX5Dm+R\nyd+vj7W8lb9ks9iXca5K/9unjdkRbAr6Nuxh9JF3hzF4xLviVZrOAYjDffLEeyBd\nSTdZW62eSsLEAdAU0y7ppeZ59ASVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHFB\nisMFY9X+2sDzt3L2mDT1uFNfJ00mOMcjfNZEKWmxUD0zSJeSCekuYubSAD0ISbkJ\n+0qF1VO+AMKuvzBqEL5h7/MSI7+UeyuUIYY82P0fmerwDVAC6+hmwq3Z9fWXrZVV\n9G8ffAT/4MFI7K/36kaSxvgc5l08NKQpOHkaMX08JAKX4WhZFpOgWLbmnklsWFcj\n7kTdnGw4WNOS28ZSJNyLTUGgJdqEFX31afAnnxKg1fsIOSFZ9L9yga9lW1NMLh4d\n5TlYEbilobqP7fMvvyi+lA9KHtttKQPRzf1ABYE2euXzMlAQ931CUXFYmV/Ik8u1\nto3v9eJsS3hEHIITqx8=\n-----END CERTIFICATE-----"
  # It should go without saying but... don't do this, example purposes only
  app_key  = "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCtvJaa/lg4mIDu\n4IqmVjEfQWR1vZYWnfKZeGPKdNQA3n7z9Hb/wbO1LFs0hrYDkdWIy+TpVAV1TZy2\neUEsOD+lLiFqw7E6NTXVupWLuZtHA3vc/sjfAVe4MZ8FhKYYMYlQEn0B0zpxNw5y\nnwIXK7pP+UtKByeyme8dpJL9wb1Ol6aLla6C+IGsENWs+AvM7bewlaKsntO5aiUf\nVAeHqvIKBHn/89b+vDx12wX5CEb2JUCZM6b+nYX5Dm+Ryd+vj7W8lb9ks9iXca5K\n/9unjdkRbAr6Nuxh9JF3hzF4xLviVZrOAYjDffLEeyBdSTdZW62eSsLEAdAU0y7p\npeZ59ASVAgMBAAECggEAAb/odF8jXE6M3dr9CnfLvtjVvinOnSOyEcGYn61VhTy4\nYpSPrjuxJ53uvTSuGJMbZ2lGQONLusaxUVUfRua6HVu9kmmuGzv18tUSNHoGCk0K\nrksSksxcqco2I8QWOCAnldrZz27lI8a+KoFXcAxMsAl+rJwt1iqesdm6cTvGQEha\na4LPedZssKj33dhQIpA1y+kBwLLnxHA8G3HgJmc8ZY6ZmEZ2qaUmMxGIixbb8pRy\nJRVXgGUGwNzfyAnXvpb+qxJZnIOAq/NZhVB3879J7SVWuYEpG8b+BvowWoWhsgbr\nJ7CIZNByR8pdYvJ1GffTnQDOTG3HML+UUFWGT0aycQKBgQDqak/g+eBZ+kMTMAjw\nfN+XLyVVLNlwOTTJ+DlYTvJV0xuuEYAeEC2Y+Siy39GcW109W8bndSpBSqV3yB7j\nx0KPQqY4ETKvxIPCGYmmssjrFtGD1ygbFcvl01Av5JP6DJbtDZfu9xe8utAK3zLP\nzfogdyY+Ef9og751qkjPFzItDwKBgQC9u/Jp/LiIPlkxGx5vh8aeIbV51Nlgpv7X\nZfKAkWVLOmbMXiN0n4C8OhXFq0mofrOP1awiKQ0y4cEnh9/R2UZ0zVKPhkW9+0Kv\nbTMAHvRgn1lqG1hG2U7CJnVTiI9QtOzEAz+tchXiKf/19BAt+S287ZLyX7/WS71t\nQcDqFMp8GwKBgFT3wgpvKFYU83kiASuCZ9059pNAFXSrF6pZsheDTi2zvqXCrCi5\nfn2jWpAztpuxNkPGX3uIKY/PCdk4DZJMqKCa7PsHqNKzLXsOnKlyxocIF1ttgpkG\ntoiQptElTknlhFNaiQbSQ6ViJYS7UISoSZC4/4CiL2znzAKEfa2q38IbAoGAIckT\n85eS7H/dtgbUNpwA3Cu4ewdR5goWmxiGRCqf1PODVqT0v1GfxOS698X2idB1/QjZ\nbAPPW94jXPyu+FkuWKIvL2uDg774MvDJAh6A+aumamSQJZ2QjrX2cneAvahZ+NVz\nQ1lrWCiOcaeSMf2LDXdokUxHhstZ4dixl304ST0CgYBsQ8Wx74qTNe7WMuqQAyAU\nT20qAqqoBCEwMXxW6hH6kAuWIumLUe0pvZ9NGCIKKK/HYYJPjIxIouxhhcPgktvs\n3tfhmSP50W25fKGQq5qMyIMa2BNmfwmLvtMAPHO9Cp7uVV0MftR4lQR9XsYgW5h7\nNTQHDBnmskQ6ZsyolLJWRQ==\n-----END PRIVATE KEY-----"
}
