flutter_engineer_codecheck ...
flowchart TB
  subgraph Arrows
    direction LR
    start1[ ] -..->|read| stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    start2[ ] --->|listen| stop2[ ]
    style start2 height:0px;
    style stop2 height:0px;
    start3[ ] ===>|watch| stop3[ ]
    style start3 height:0px;
    style stop3 height:0px;
  end
  subgraph Type
    direction TB
    ConsumerWidget((widget));
    Provider[[provider]];
  end

  searchGitHubDataUseCaseProvider[["searchGitHubDataUseCaseProvider"]];
  searchApiNotifierProvider[["searchApiNotifierProvider"]];
  searchApiRepositoryProvider[["searchApiRepositoryProvider"]];
  textEditingControllerProvider[["textEditingControllerProvider"]];
  formKeyProvider[["formKeyProvider"]];
  SearchApiListPage((SearchApiListPage));
  ApiShowPage((ApiShowPage));

  searchApiNotifierProvider ==> SearchApiListPage;
  textEditingControllerProvider ==> SearchApiListPage;
  formKeyProvider ==> SearchApiListPage;
  searchGitHubDataUseCaseProvider -.-> SearchApiListPage;
  searchApiNotifierProvider ==> ApiShowPage;
  searchApiNotifierProvider ==> searchGitHubDataUseCaseProvider;
  searchApiRepositoryProvider ==> searchGitHubDataUseCaseProvider;
