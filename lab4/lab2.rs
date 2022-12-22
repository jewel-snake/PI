use std::io::Read;
fn main() {
  let mut handle = std::io::stdin();
  let mut input = String::new();
  handle.read_to_string(&mut input);
  let x = input.trim().parse::<f32>().unwrap();
  println!("{}",x.powi(2).cos()-x.powi(2).sin());
}