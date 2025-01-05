import gleam/list
import gleam/result
import gleam/io
import gleeunit
import gleeunit/should
import htmgrrrl.{type SaxEvent, type Attribute, Attribute, StartElement}

pub fn main() {
  gleeunit.main()
}

fn is_og_image(attrs: List(Attribute)) -> Bool {
  list.any(attrs, fn(attr) {
    case attr {
      Attribute(_, _, "property", "og:image") -> True
      _ -> False
    }
  })
}

fn content_attr_values(attrs: List(Attribute)) -> List(String) {
  attrs
  |> list.map(fn(attr) {
    case attr {
      Attribute(_, _, "content", content) -> Ok(content)
      _ -> Error(Nil)
    }
  })
  |> result.values
}

fn gather_all_og_image_contents(state: List(String), _line: Int, event: SaxEvent) -> List(String) {
  case event {
    StartElement(_, "meta", _, attrs) ->
      case is_og_image(attrs) {
        False -> state
        True -> {
          let contents = content_attr_values(attrs)

          state
          |> list.append(contents)
        }
      }

    _ -> state
  }
  |> io.debug
}

pub fn example_test() {
  let content = "https://example.com/image.webp"

  let return =
    { "<html><head><meta property=\"og:image\" content=\"" <> content <> "\"/></head><body></body></html>" }
    |> htmgrrrl.sax([], gather_all_og_image_contents)
    |> io.debug

  return
  |> should.equal(Ok([content]))
}
