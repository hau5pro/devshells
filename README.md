# Dev Environments

## Register Environment
Move Repository to: `/home/{user}/devshells` or desired path.

Add to registry:
```bash
nix registry add devshells path:/home/{user}/devshells
```

## Enter Environment
```bash
nix develop devshells#node22
```
