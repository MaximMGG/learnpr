

use trpl::{Html, Either};
use std::time::Duration;


async fn page_title(url: &str) -> (&str, Option<String>) {
    let response = trpl::get(url).await;
    let response_text = response.text().await;
    (url, Html::parse(&response_text).select_first("title").map(|title| title.inner_html()))
}

fn page_title_2(url: &str) -> impl Future<Output = Option<String>> {
    async move {
        let text = trpl::get(url).await.text().await;
        Html::parse(&text).select_first("title").map(|title| title.inner_html())
    }
}

// fn main() {
//     let args: Vec<String> = std::env::args().collect();
//
//     trpl::block_on(async {
//         let title_fut_1 = page_title(&args[1]);
//         let title_fut_2 = page_title(&args[2]);
//
//        let (url, maybe_title) =
//             match trpl::select(title_fut_1, title_fut_2).await {
//                 Either::Left(left) => left,
//                 Either::Right(right) => right,
//             };
//         println!("{url} returned first");
//
//         match maybe_title {
//             Some(title) => println!("Its page title was: '{title}'"),
//             None => println!("It had no title.")
//         }
//     });
// }
//

fn main() {
    trpl::block_on(async {
        let handle = trpl::spawn_task(async {
            for i in 1..10 {
                println!("Hi numnber {i} from the first task!");
                trpl::sleep(Duration::from_millis(5)).await;
            }
        });

        for i in 1..5 {
            println!("Hi number {i} from the second task!");
            trpl::sleep(Duration::from_millis(5)).await;
        }

        handle.await.unwrap();
    });

    trpl::block_on(async {
        main2().await;
    });
    trpl::block_on(async {
        main3().await;
    });
    // trpl::block_on(async {
    //     main4().await;
    // });
    trpl::block_on(async {
        main5().await;
    });
}


async fn main2() {

    let fut1 = async {

        for i in 1..10 {
            println!("Hi numbe {i} from first task!");
            trpl::sleep(Duration::from_millis(50)).await;
        }
    };

    let fut2 = async {
        for i in 1..5 {
            println!("Hi numbe {i} from second task!");
            trpl::sleep(Duration::from_millis(50)).await;
        }
    };

    println!("Task created");
    trpl::join(fut1, fut2).await;

}

async fn main3() {
    let (tx, mut rx) = trpl::channel();

    let val = String::from("gi");
    tx.send(val).unwrap();

    let received = rx.recv().await.unwrap();
    println!("received '{received}'");
}

async fn main4() {
    let (tx, mut rx) = trpl::channel();

    let vals = vec![
        String::from("hi"),
        String::from("from"),
        String::from("code"),
        String::from("async"),
    ];

    for val in vals {
        tx.send(val).unwrap();
        trpl::sleep(Duration::from_millis(50)).await;
    }

    while let Some(value) = rx.recv().await {
        println!("received '{value}'");
    }
}

async fn main5() {
    let (tx, mut rx) = trpl::channel();

    let tx_fut = async {
        let vals = vec![
            String::from("hi"),
            String::from("from"),
            String::from("the"),
            String::from("future"),
        ];

        for val in vals {
            tx.send(val).unwrap();
            trpl::sleep(Duration::from_millis(500)).await;
        }
    };

    let rx_fut = async {
        while let Some(value) = rx.recv().await {
            println!("received '{value}'");
        }
    };

    trpl::join(tx_fut, rx_fut).await;

}
