# memRAMP

> A demo to show memory management with Edera Protect

**NOTE**: this is a difficult demo to show, purely on timings to help demostrate
the memory management of Edera Protect. A recording will be made available to
share instead of performing the demo.

## Setup

1. Setup an Edera Cluster.
1. Setup either:
  a. Three `ssh` connections to the Edera Node within a single window.
  b. `ssh` onto the Edera Node and use `tmux` to create three panes.
1. Follow the `edera-daemon` in the bottom pane.
  
    ```sh
    journalctl -fu protect-daemon
    ```

1. Show the current Edera Protect Zones in the pane above the `edera-daemon`.

    ```sh
    protect zone top
    ```

1. Prepare the terminal with the following commands in the pane above the
`protect zone top` command.:

    ```sh
    protect zone update-resources -m 4096 k8s_default_memramp-edera -p static
    protect zone update-resources -m 256 k8s_default_memramp-edera -p static
    protect zone update-resources k8s_default_memramp-edera -p dynamic
    ```

1. Make sure the `edera` runtime is set in the cluster:

    ```sh
    kubectl apply -f kubernetes/runtime-edera.yaml
    ```

1. Run the `memramp` demo:

    ```sh
    kubectl apply -f kubernetes/memramp-pod-edera.yaml
    ```

1. When the pod is running, follow the logs in the top pane:

    ```sh
    kubectl logs memramp-edera -f
    ```

1. Read the logs to explain that the memory within the application is
increasing.
1. When the countdown starts, increase the memory within the pod:

    ```sh
    protect zone update-resources -m 4096 k8s_default_memramp-edera -p static
    ```

1. When the application has released the memory, reduce the memory available to
the pod:

    ```sh
    protect zone update-resources -m 256 k8s_default_memramp-edera -p static
    ```

1. Let Edera Protect manage this instead with the `dynamic` policy:

    ```sh
    protect zone update-resources k8s_default_memramp-edera -p dynamic
    ```
