
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Discursos da Assembleia Nacional Constituinte

<!-- badges: start -->
<!-- badges: end -->

Esse repositório foi criado para disponibilizar os discursos proferidos
pelos Constituintes na Assembleia Nacional Constituinte (1987-1988).

O repositório contém a seguinte estrutura:

``` r
fs::dir_tree()
#> .
#> ├── dados
#> │   ├── atas
#> │   │   ├── janeiro_88.pdf
#> │   │   └── novembro_87.pdf
#> │   ├── csv
#> │   │   ├── janeiro_88.csv
#> │   │   └── novembro_87.csv
#> │   └── rds
#> │       ├── janeiro_88.rds
#> │       └── novembro_87.rds
#> ├── discursos_anc.R
#> ├── discursos_anc.Rproj
#> ├── README.md
#> └── README.Rmd
```

O arquivo [`discursos_anc.R`](discursos_anc.R) contém o script criado
para fazer a leitura dos arquivos, transformações e a extração do
produto final: uma tabela com o nome do constiuinte, o discurso e a ata.

A pasta docs contém três pastas: uma pasta com as atas baixadas (em
formato `.pdf`) e duas pastas com os dados produzidos: dados salvaos em
formato separado por vírgula (`.csv`) e formato binário do R (`.rds`).

Trata-se de uma coleta ainda em desenvolvimento. Constam nas pastas os
discursos das atas de novembro de 1987 e janeiro de 1988, pois foram os
períodos solicitados pelo pesquisador Matheus Conde Pires (UNESP) - que
instigou a produção desses dados.

Dúvidas e sugestões encaminhar para <jonathanmbferreira@outlook.com>
