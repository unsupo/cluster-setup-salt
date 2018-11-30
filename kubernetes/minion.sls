include:
  - kubernetes.repo

kubernetes_kubectl_pkgs:
  pkg.installed:
    - pkgs:
      - kubeadm
      - kubelet
      - kubectl
    - require:
      - pkgrepo: kubernetes_repository
