# Levi

Levi monorepo including:

- `@levi/design`: Design system with tokens, assets and more
- `@levi/portal`: Web Portal
- `@levi/game`: Levi Game

**Summary**

1. [Getting Started](#getting-started)
2. [Development](#development)

## Requeriments

1. Linux (or WSL)
2. make
3. curl
4. shasum

## Getting Started

```bash
make
make build
```

> :bulb: VSCode ready workspace `code ./.vscode/workspace.code-workspace`

## Getting help

```bash
make help
```

### Architecture

```
Package
-----------------------------------------------------------------
| Module                                                        |
|                                                               |
| == Client Context ==                                          | 
| ----------------------------                                  |
| | Pages                    |   ----------   ------------      |
| |                          ==> | Routes |   | EventBus |      |
| | ------------------------ |   ----------   ------------      |
| | | Pure Component       | |   ---------------                |
| | ------------------------ <== | Composables |                |
| |                     /\   |   ---------------                |
| ----------------------||----                                  |
|                       ||                                      |
| == Server Context ==  ||                                      |
| ----------------------||----                                  |
| | Middlewares         \/   |                                  |
| ----------------------------                                  |
-----------------------------------------------------------------
```

So that everything is JavaScript, and we try to put composables and middlewares as PureScript side-effect free functions ASAP. In future we want to have everything in PureScript.