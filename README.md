# Discursos da Assembleia Nacional Constituinte
Jonathan Morais Barcellos Ferreira

<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![License: CC BY
4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
<!-- badges: end -->

Esse repositório foi criado para disponibilizar os discursos proferidos
pelos Constituintes na Assembleia Nacional Constituinte (1987-1988).

O repositório contém a seguinte estrutura:

``` r
fs::dir_tree()
#> .
#> ├── dados
#> │   ├── atas
#> │   │   ├── ata_n_001.pdf
#> │   │   ├── ata_n_002.pdf
#> │   │   ├── ata_n_003.pdf
#> │   │   ├── ata_n_004.pdf
#> │   │   ├── ata_n_005.pdf
#> │   │   ├── ata_n_006.pdf
#> │   │   ├── ata_n_007.pdf
#> │   │   ├── ata_n_008.pdf
#> │   │   ├── ata_n_009.pdf
#> │   │   ├── ata_n_010.pdf
#> │   │   ├── ata_n_011.pdf
#> │   │   ├── ata_n_012.pdf
#> │   │   ├── ata_n_013.pdf
#> │   │   ├── ata_n_014.pdf
#> │   │   ├── ata_n_015.pdf
#> │   │   ├── ata_n_016.pdf
#> │   │   ├── ata_n_017.pdf
#> │   │   ├── ata_n_018.pdf
#> │   │   ├── ata_n_019.pdf
#> │   │   ├── ata_n_020.pdf
#> │   │   ├── ata_n_021.pdf
#> │   │   ├── ata_n_022.pdf
#> │   │   ├── ata_n_023.pdf
#> │   │   ├── ata_n_024.pdf
#> │   │   └── ata_n_025.pdf
#> │   ├── csv
#> │   │   ├── ata_n_001.csv
#> │   │   ├── janeiro_88.csv
#> │   │   └── novembro_87.csv
#> │   └── rds
#> │       ├── ata_n_001.rds
#> │       ├── janeiro_88.rds
#> │       └── novembro_87.rds
#> ├── discursos_anc.R
#> ├── discursos_anc.Rproj
#> ├── LICENSE.md
#> ├── README.md
#> ├── README.qmd
#> └── README.rmarkdown
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

## Baixando as atas:

As atas foram baixadas da seguinte forma:

``` r
for (i in stringi::stri_pad(1:25, 3, pad=0)){
    httr::GET(paste0("https://www.senado.leg.br/publicacoes/anais/constituinte/N",i,'.pdf'), httr::write_disk(paste0("dados/atas/ata_n_",i,'.pdf')))
}
```

Observe que a função GET requisita no site do Senado a ata da
Constituinte de Nº i, em que i é um número de 001 a 025, logo depois
salva no disco.

## Extraindo os discursos:

No exemplo abaixo, extraímos os dicursos da Ata nº 001 e salvamos em
dois tipos de arquivos: um csv e outro rds:

``` r
source('discursos_anc.R')
ata_n_001 <- discursos_anc('dados/atas/ata_n_001.pdf')

readr::write_csv(ata_n_001, 'dados/csv/ata_n_001.csv')
saveRDS(ata_n_001, 'dados/rds/ata_n_001.rds')
```

## Output

A função vai retornar um objeto data.frame (uma tabela). Essa tabela foi
salva em dois formatos: um .csv (separado por vírgulas, que pode ser
utilizado no Excel ou Google Sheets) e um .rds (arquivo de dados nativo
do R).

A estrutura dos dados é a seguinte:

| Coluna   | Tipo | Descrição                                                                                                                                                      | Exemplo                      |
|----------|------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|
| nome     | chr  | O nome do constituinte                                                                                                                                         | O SR. NILSON GIBSON          |
| discurso | chr  | O discurso do constituinte                                                                                                                                     | É evidente que nosso regime… |
| ano      | chr  | Identifica a ata conforme o sistema estabelecido pelo Diário da ANC. Então o Diário ANC ANO I Nº 005 ficará ano_005. O Diário ANC ANO II Nº 128 ficará ano_128 | ano_007                      |

Cabe destacar que os únicos tratamentos feitos nos dados são os
presentes no script [discursos_anc.R](discursos_anc.R). Portanto, antes
de usar os dados, analise se você precisa fazer alguma faxina (o que
será provavel).

Outro destaque: os discursos foram separados a partir de expressões
regulares (*regex*), então é possível que alguns discursos não tenham
sido discriminados, isto é, pode ser que o discurso de um constituinte X
esteja junto com o discurso de um constituinte Y.

## Tabulizer

Talvez você não consiga instalar o pacote Tabulizer o que vai exigir que
sejam feitas algumas adaptações no script
[discursos_anc.R](discursos_anc.R). Primeiro, recomendo que você leia a
documentação do pacote
[Tabulizer](https://github.com/ropensci/tabulizer). Depois, é preciso
que você utilize a versão disponível no rOpenSci:

``` r
install.packages("tabulapdf", repos = c("https://ropensci.r-universe.dev", "https://cloud.r-project.org"))
```

Atenção: o pacite tabulapdf será baixado, por isso, você deve alterar no
script [discursos_anc.R](discursos_anc.R) o pacote. Quando aparecer
Tabulizer troque por tabulapdf.
