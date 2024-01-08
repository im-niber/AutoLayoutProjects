#  SocialMediaTable

이번에는 페이스북의 피드 화면을 테이블 뷰로 구현해야함니다.

테이블 뷰 셀 내부에 스택 뷰들을 사용하여 구성하였고, 뷰 마다 콘텐츠 허깅과 컴프레션 저항(CHCR)의 우선순위를 생각해가며 레이아웃을 잡아주었습니다.

전체를 다 담고 있는 메인 스택뷰의 프로퍼티는 `.fill`로 주어서 내부를 꽉 채우게 하였고, 어떤 뷰가 늘어날지를 `contentHugging`의 우선도를 낮추면서 진행하였슴니다.

내용을 나타내는 `description`은 다 보여지는 방식으로 구현하여서 `descriptionTextView` 내부에서 `contentCompressionResistance`의 우선순위를 `.required`로 주었슴니다

그리고 이미지 뷰를 누르면 원래 이미지의 비율로 맞춰주는 제약사항을 active 해주는 이벤트를 구성하고, 해당 제약이 활성화 되어 있을때 탭을 한다면 다시 원래 사이즈로 돌아가야 하기 때문에 deactive 해주고 삭제해주었슴니다. 

테이블 뷰 셀 내부에서만 레이아웃을 수정해도 화면엔 보여지지가 않으므로 이를 노티피케이션을 사용하여 테이블 뷰에 이벤트를 보내고 `tableView.beginUpdates(), tableView.endUpdates()`를 같이 사용하여서 셀을 다시 불러오지 않고 높이의 변경만 하는 식으로 진행하였슴니다. (https://developer.apple.com/documentation/uikit/uitableview/1614908-beginupdates)

> `performBatchUpdates` 웬만하면 얘를 사용하라네요. 이 메소드는 하나의 애니메이션으로 여러 번 업데이트 하는 경우에 사용하라고 권장됨니다. 지금 같은 경우엔 이 메소드가 더 적절하겠슴니다.

---

확실히 스택 뷰로 관리하면 좀 더 편한거 같기는 함니다. 대신 우선순위 같은 부분을 잘 고려해야한다~
