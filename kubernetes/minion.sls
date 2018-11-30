include:
  - kubernetes.repo

kubernetes_kubectl_pkgs:
  pkg.installed:
    - pkgs:
      - kubeadm
      - kubelet
      - kubectl
    - require:
      - cmd: kubernetes_repository

#kubernetes_kubectl_init:
#  cmd.run:

