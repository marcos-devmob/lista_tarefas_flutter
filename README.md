# Lista de Tarefas Flutter

Este é um aplicativo simples de **Lista de Tarefas** feito em **Flutter**, que permite:

- Adicionar tarefas com validação (não permite vazias);
- Marcar tarefas como concluídas;
- Remover tarefas com swipe (gesto Dismissible);
- Desfazer remoção via SnackBar;
- Ordenar tarefas concluídas e pendentes;
- Persistência local usando JSON no dispositivo.

---

## 📱 Tela do App

![Tela do App](<img width="720" height="1280" alt="Screenshot_20251003_214326" src="https://github.com/user-attachments/assets/70c315f3-759f-4cfe-8461-20aa390e142c" />) 

<img width="720" height="1280" alt="Screenshot_20251003_214507" src="https://github.com/user-attachments/assets/6f876810-4649-4578-9dc1-886542e219c4" />

<img width="720" height="1280" alt="Screenshot_20251003_214533" src="https://github.com/user-attachments/assets/aee9d1f6-a632-49ef-b830-1564be341427" />


---

## 💻 Tecnologias utilizadas

- Flutter & Dart  
- Path Provider (para salvar dados localmente)

---

## 🚀 Funcionalidades

1. **Adicionar tarefas**  
   - Validação para não adicionar tarefas vazias.  
   - Limpa automaticamente o campo após adicionar.

2. **Marcar tarefas como concluídas**  
   - Checkbox que atualiza status.  
   - Ícone muda de acordo com o status.

3. **Remover tarefas**  
   - Swipe para remover.  
   - SnackBar para desfazer ação.

4. **Persistência local**  
   - Tarefas salvas em arquivo JSON.  
   - Mantém estado ao reiniciar o app.

---

## 🛠 Como rodar

1. Clone o repositório:  
```bash
git clone https://github.com/seu-usuario/lista_tarefas_flutter.git
```
2. Entre na pasta do projeto:
```bash
cd lista_tarefas_flutter
```
3. Instale as dependências:
```bash
flutter pub get
```
4. Rode o app:
```bash
flutter run
```
---

## 📂 Estrutura de arquivos

```vbnet
lib/
 ├─ main.dart       # Código principal do app
pubspec.yaml        # Dependências do Flutter
```
---
[GitHub](https://github.com/marcos-devmob) | [LinkedIn](https://www.linkedin.com/in/marcosaurelioalves/)    

