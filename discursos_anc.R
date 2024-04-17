discursos_anc <- function(arquivo){
  n_pages <- tabulizer::get_n_pages(arquivo)
  
  cli::cli_progress_step("Serão extraídas {n_pages} páginas.")
  
  col_1 <- c(top = 59.97150997151, left = 40.222222222222, bottom = 791.623931623932, 
             right = 211.74074074074)
  col_2 <- c(top = 59.97150997151, left = 210.54131054131, bottom = 795.222222222222, 
             right = 383.25925925926)
  col_3 <- c(top = 58.77207977208, left = 383.25925925926, bottom = 792.823361823362, 
             right = 557.17663817664)
  
  cli::cli_progress_bar("Extraindo texto", total = n_pages)
  for (i in seq(n_pages)){
    texto_col_1 <- tabulizer::extract_text(arquivo, pages = i, area = list(col_1))
    texto_col_2 <- tabulizer::extract_text(arquivo, pages = i, area = list(col_2))
    texto_col_3 <- tabulizer::extract_text(arquivo, pages = i, area = list(col_3))
    
    texto <- stringr::str_c(texto_col_1, texto_col_2, texto_col_3)
    
    dados <- data.frame(
      pagina = i,
      texto = texto
    )
    
    if (i == 1){
      dados_gerais <- dados
    } else {
      dados_gerais <- dplyr::bind_rows(dados_gerais, dados)
    }
    
    cli::cli_progress_update()
    
  }
  
  cli::cli_process_done()
  
  cli::cli_progress_step("Foram extraídas {n_pages} páginas")
  
  texto <- dados_gerais
  texto <- texto |>
    dplyr::mutate(
      ata = texto |> stringr::str_extract('ANO(.*?)\\d{3}')
    )
  
  texto <- texto |> tidyr::fill(ata)
  
  novo <- texto |>
    dplyr::group_by(ata) |>
    dplyr::summarise(texto = paste(texto, collapse = ' '))
  
  n_novo <- nrow(novo)
  
  cli::cli_progress_step("Foram extraídas {n_novo} atas")
  
  
  cli::cli_progress_bar("Extraíndo discursos dos deputados:")
  for (p in 1:nrow(novo)){
    nome <- paste("ano", stringr::str_extract(novo$ata[p], "\\d{3}"), sep = '_')
    assign(nome, novo$texto[p])
    assign(nome, stringr::str_trim(get(nome)) |> stringr::str_squish())
    assign(nome, stringr::str_replace_all(get(nome),"\\b((O|A) (SR|SRA)\\..*?):", "\n\\1:"))
    assign(nome, stringr::str_split(get(nome), "\n")[[1]])
    assign(nome, get(nome)[-1])
    for (i in seq(length(get(nome)))) {
      constituinte <- get(nome)[i] |> stringr::str_extract_all("\\b((O|A) (SR|SRA)\\..*?\\b\\w+ \\w+)") |> unlist()
      
      dado <- data.frame(
        nome = constituinte,
        discurso = get(nome)[i],
        ano = paste("ano", stringr::str_extract(novo$ata[p], "\\d{3}"), sep = '_')
      )
      
      if (i == 1) {
        discurso_nome <- dado
      } else {
        discurso_nome <- rbind(discurso_nome, dado)
      }
      cli::cli_progress_update()
    }
    
    if (p == 1){
      discurso_todos <- discurso_nome
    } else {
      discurso_todos <- rbind(discurso_todos, discurso_nome)
    }
    
  }
  
  dep <- length(unique(discurso_todos$nome))
  
  cli::cli_progress_step("Foram extraídos os discursos de {dep} costituintes")
  
  discurso_todos
}