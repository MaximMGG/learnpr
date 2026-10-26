import std;



struct Job {
  n: i32
}

struct Result {
  n: i32,
  digits: i32
}


fn count_digits(n: i32) -> i32 {32}

thread_fn worker() {
  loop {
    let job = qget<Job>();
    guard job.n >= 0 else {break;}
    qput(Result{n: job.n, digits: count_digits(job.n)})
  }
}


fn main() {
  let n = max(1, hardware_threads());
  for i in 8 {qput(Job{n: 1 << (i * 3) as i32})};
  for i in n {qput(Job{n: -1});}
  var ids: i64[>..] = [];
  for i in n {
    ids.push(thread_spawn(worker));
  }
  var total = 0;
  for i in 8 {
    let r = qget<Result>();
    total += r.digits;
  }
  for id in ids {
    thread_wait(id);
  }
  print(n, " workers, ", total, " digits in total");

}
