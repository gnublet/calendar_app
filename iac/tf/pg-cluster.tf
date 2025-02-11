resource "kubernetes_manifest" "cluster_pg_cluster" {
  manifest = {
    "apiVersion" = "postgresql.cnpg.io/v1"
    "kind" = "Cluster"
    "metadata" = {
      "name" = "pg-cluster"
      "namespace" = "default"
    }
    "spec" = {
      "bootstrap" = {
        "initdb" = {
          "database" = "calendar_db"
          "owner" = "app"
          "secret" = {
            "name" = "postgres-secret"
          }
        }
      }
      "imageName" = "ghcr.io/cloudnative-pg/postgresql:17.2"
      "instances" = 3
      "managed" = {
        "services" = {
          "additional" = [
            {
              "selectorType" = "rw"
              "serviceTemplate" = {
                "metadata" = {
                  "name" = "cluster-example-rw-lb"
                }
                "spec" = {
                  "type" = "LoadBalancer"
                }
              }
            },
          ]
        }
      }
      "storage" = {
        "size" = "1Gi"
      }
      "superuserSecret" = {
        "name" = "postgres-superuser-secret"
      }
    }
  }
}

resource "kubernetes_manifest" "secret_postgres_secret" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "password" = "cGFzc3dvcmQ="
      "username" = "YXBw"
    }
    "kind" = "Secret"
    "metadata" = {
      "name" = "postgres-secret"
      "namespace" = "default"
    }
    "type" = "kubernetes.io/basic-auth"
  }
}

resource "kubernetes_manifest" "secret_postgres_superuser_secret" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "password" = "cGFzc3dvcmQ="
      "username" = "YXBw"
    }
    "kind" = "Secret"
    "metadata" = {
      "name" = "postgres-superuser-secret"
      "namespace" = "default"
    }
    "type" = "kubernetes.io/basic-auth"
  }
}

resource "kubernetes_manifest" "secret_postgres_credentials" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Secret"
    "metadata" = {
      "name" = "postgres-credentials"
      "namespace" = "default"
    }
    # "stringData" = {
    #   "url" = "postgres://app:password@pg-cluster-rw:5432/calendar_db?sslmode=disable&search_path=public"
    # }

    # this resource doesn't allow stringdata since it gets set to null (see https://github.com/hashicorp/terraform-provider-kubernetes/issues/2184#issuecomment-1632024414)
    "data" = {
      "url" = "cG9zdGdyZXM6Ly9hcHA6cGFzc3dvcmRAcGctY2x1c3Rlci1ydzo1NDMyL2NhbGVuZGFyX2RiP3NzbG1vZGU9ZGlzYWJsZSZzZWFyY2hfcGF0aD1wdWJsaWM="
    }
    "type" = "Opaque"
  }
}

resource "kubernetes_manifest" "atlasschema_atlasschema_pg" {
  manifest = {
    "apiVersion" = "db.atlasgo.io/v1alpha1"
    "kind" = "AtlasSchema"
    "metadata" = {
      "name" = "atlasschema-pg"
      "namespace" = "default"
    }
    "spec" = {
      "schema" = {
        "sql" = <<-EOT
        CREATE TABLE public.users (
           id serial4 NOT NULL,
           email varchar NOT NULL,
           hashed_password varchar NOT NULL,
           is_active bool DEFAULT true NOT NULL,
           created_at timestamptz DEFAULT now() NULL,
           CONSTRAINT users_pkey PRIMARY KEY (id)
         );
         CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);
         CREATE INDEX ix_users_id ON public.users USING btree (id);
        
        
         CREATE TABLE public.events (
           id serial4 NOT NULL,
           title varchar NOT NULL,
           description varchar NULL,
           start_time timestamp NOT NULL,
           end_time timestamp NOT NULL,
           user_id int4 NOT NULL,
           CONSTRAINT events_pkey PRIMARY KEY (id),
           CONSTRAINT events_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id)
         );
        
        
         CREATE TABLE public.oauth2_clients (
           id serial4 NOT NULL,
           client_id varchar NOT NULL,
           client_secret varchar NOT NULL,
           redirect_uri varchar NOT NULL,
           user_id int4 NOT NULL,
           CONSTRAINT oauth2_clients_pkey PRIMARY KEY (id),
           CONSTRAINT oauth2_clients_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
         );
         CREATE UNIQUE INDEX ix_oauth2_clients_client_id ON public.oauth2_clients USING btree (client_id);
         CREATE INDEX ix_oauth2_clients_id ON public.oauth2_clients USING btree (id);
        EOT
      }
      "urlFrom" = {
        "secretKeyRef" = {
          "key" = "url"
          "name" = "postgres-credentials"
        }
      }
    }
  }
}
