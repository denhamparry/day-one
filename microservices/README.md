# Microservices

> Show that Edera Protect can work with containerD to demostate that people can
migrate workloads to Edera Protect.

## Setup

1. Create an Edera Protect cluster.
1. Add the Edera Protect Runtime to the cluster:

    ```sh
    kubectl apply -f kubernetes/runtime-edera.yaml
    ```

1. Apply the Microservices yaml:

    ```sh
    kubectl apply -f kubernetes/better-together.yaml
    ```

### Extras

1. `ssh` onto the node to show the Edera Protect Zones:

    ```sh
    protect zone list
    ```

1. Show that Kubernetes has been set to run on both Edera Protect and
containerD:

    ```sh
    kubectl get endpoints
    ```

1. Show that the Edera Protect Runtime is running:

    ```sh
    kubectl get svc
    ```

    a. View the website in the browser.
    b. Refresh the page and a banner will display when the Edera Protect
    frontend pod is being used.
