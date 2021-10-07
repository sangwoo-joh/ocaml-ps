#include <stdio.h>
#include <queue>

int main(){
  int num;
  scanf("%d", &num);

  std::queue<int> q;
  // add to queue
  for (int n = 1; n<=num; n++){
    q.push(n);
  }

  while(q.size() != 1) {
    q.pop(); // drop
    if(q.size() == 1)
      break;

    int top = q.front();
    q.pop();
    q.push(top);
  }

  printf("%d\n", q.front());

  return 0;
}
