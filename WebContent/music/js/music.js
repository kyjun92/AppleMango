//node 구현
function Node(element) {
    this.element = element;
    this.next = null;
    this.previous = null;
}
 
// Linked List 구현
function LinkedList() {
    this.head = new Node("head");
    this.find = find;
    this.append = append;
    this.insert = insert;
    this.remove = remove;
    this.toString = toString;
    this.findPrevious = findPrevious;
    this.l = l;
    this.num_index=num_index;
}
 
// 노드 찾기
function find(item) {
    var currNode = this.head;
    while(currNode.element != item) {
        currNode = currNode.next;
    }
    return currNode;
}
 
// 이전 노드 찾기
function findPrevious(item) {
    var currNode = this.head;
    while(currNode.element != item) {
        currNode = currNode.next;
    }
    return currNode.previous;
}
 
// 노드 추가
function append(newElement) {
    var newNode = new Node(newElement); //새로운 노드 생성
    var current = this.head; // 시작 노드
    while(current.next != null) { // 맨 끝 노드 찾기
        current = current.next;
    }
    newNode.previous = current;
    current.next = newNode;
    
    
}
 
//노드 중간 삽입
function insert(newElement, item) {
    var newNode = new Node(newElement); //새로운 노드 생성
    var current = this.find(item); // 삽입할 위치의 노드 찾기
    newNode.previous = current; // 찾은 노드를 새로운 노드가 previous로 가리키기
    if(current.next != null){
    	newNode.next = current.next; // 찾은 노드의 next를 새로은 노드가 next로 가리키기
    	current.next.previous = newNode; // 찾은 노드의 next 노드가 새로운 노드를 previous로 가리키도록 하기

    }
    current.next = newNode; // 찾은 노드가 새로운 노드를 next로 가리키도록 하기
}
 
//노드 삭제
function remove(item) {
    var current = this.find(item); // 삭제할 노드 찾기
    if(current.next != null) current.next.previous = current.previous; // 삭제할 노드의 next 노드가 previous로 삭제할 노드의 previous를 가리키도록 하기
    current.previous.next = current.next; // 삭제할 노드의 previous 노드가 next로 삭제할 노드의 next 가리키도록 하기
    current.next = null; // 삭제할 노드의 연결 초기화
    current.previous = null; // 삭제할 노드의 연결 초기화
}
 
// 연결 리스트의 요소들을 출력
function toString() {
    var str = '[ ';
    var currNode = this.head;
    while(currNode.next != null){
        str += currNode.next.element+' ';
        currNode = currNode.next;
    }
    return str+']';
}

function l(){
	var currNode = this.head;
	var count=0;
    while(currNode.next != null) {
        currNode = currNode.next;
        count++;
    }
    return count;
}
function num_index(i){
	var currNode = this.head;
	var x = 0;
	while(x<i){
		currNode = currNode.next;
		x++;
	}
	
	return currNode;
}

var linkedList = new LinkedList();
var linkedList2 = new LinkedList();