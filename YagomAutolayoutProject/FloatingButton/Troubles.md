#  Floating Button 

메뉴 버튼을 누르면 튀어오르는 애니메이션과 함께 스택 뷰가 보이는 화면을 구성해야함니다.

구현한 방식은 버튼을 하나 만들고 위에 스택뷰를 만들어서 둘 사이의 오토레이아웃 제약을 설정해줬음

### 뷰 위치, 크기에 따른 애니메이션 효과

애니메이션 처리에서 조금 신기했던 부분은, 스택 뷰의 leading, trailing으로 아래 버튼과 제약을 걸어주면 애니메이션은 왼쪽에서 튀어나오고, centerXanchor로 제약을 걸면 오른쪽에서 튀어나오는 효과를 볼 수 있었다.

-> leading, trailing으로 잡으면 너비와 시작 위치가 다르다. (centerX == width: 23, x: 347), (leading, trailing == width: 36, x: 336)

언뜻 보면 같은 위치 크기를 가지는 제약이더라도, 세부적인 위치, 크기에 따라 애니메이션 효과는 당연히 달라짐을 눈으로 확인할 수 있었슴니다

### 애니메이션 어색함 해결

메뉴 버튼을 누르면 스택 뷰 내부의 뷰 들이 보여지고, 다시 누르면 사라지는 애니메이션을 구현해야하는데 내부를 `UIImageView`로 구성했다가 애니메이션의 마지막에 찌그러지는 어색한 부분이 있어서 해결한 과정을 작성 해보았슴니다.

이미지가 사이즈가 안 맞아서 그런가? UIButton에 사이즈를 작게 해봄 -> XXXX

-> 이미지 뷰의 문제구나 검색하니 잘 안 나옴 -> alpha로 조절해보자.

-> 자연스러운데, 댐핑효과가 사라짐,,, 두 개를 같이 써보면 ?

-> 마지막에 찌그러져서 남아있는 부분을 꽤 자연스럽게 고침

-> 근데 스택 뷰가 히든 되는 처리가 느려서 그런건가? 라고 생각이 들어서 내부 뷰가 전부 히든이면 스택 뷰도 히든 처리를 따로 해줌

-> 매우 깔끔하게 해결이 되었따...!
