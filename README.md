# OCI: OCI For OpenConnect Interface

## HOWTO

To use it, first build the image (use `nerdctl` as example):

```
sudo nerdctl build -t uichcc/oci:0.1 .
```

and then, use `compose` to start the image at background

```
sudo nerdctl compose up -d 
```

