#  BarGraph

이번에는 간단한 그래프가 있는 뷰를 만들어야 함니다.

스택 뷰와 스크롤 뷰로 만들었고 스크롤 뷰 내부에는 Horizontal 뷰를 넣었씀니다.

화면 회전을 해도 똑같은 수치로 보여야 하는 부분은 그래프 뷰한테 본인의 높이 값(안전영역 topAnchor와의 차이)을 저장하고

이 높이 값을 수정하는 방식으로 구현하였슴니다.

### 화면회전시 차트 높이 계산 문제 해결

예를 들어, 세로모드일 때 80의 값을 가지는 차트가 가로모드에도 80의 값이 나오도록 유지해야 합니다. 

먼저 세로모드의 80이라는 값의 비율을 방법은 `numberStackView`의 높이를 저장해서 이를 랜덤 값의 비율 기준으로 계산했습니다. (ex. randomValue * (numberStack.bounds.height / 100))

가로모드로 회전하면 그에 맞게 `numberStackView`의 높이도 변경이 되어야합니다. 하지만 `willTransition` 내부에서 디바이스 자체의 크기는 갱신이 되는데 뷰 요소들의 높이는 아직 업데이트 되고 있지 않았슴니다.

그래서 회전 액션이 끝나고 높이를 전달할까하다가, 디바이스의 높이와 너비 비율을 가지고 `numberStackView`의 현재 높이를 바탕으로 비례식을 사용하여 기준 높이 값을 주었슴니다.

```swift
let newGraphHeight = (numberStackView.bounds.height * UIScreen.main.bounds.height) / UIScreen.main.bounds.width
```

새로운 높이 값을 바탕으로 가로모드를 하여도 비율에 맞게 조절 됨니다..!

저는 처음 시도 때 `topAnchor`랑 상수 값으로 비교해서 위와 같이 해줬는데 만약 `numberStackView`와 높이 값을 `multiplier`로 주면 위처럼 안 해줘도 괜찮슴니다...

이미 먼 길을 와버렸기에 한 번 해결 해보고싶어서 저런 방식으로 해보았씀니다
