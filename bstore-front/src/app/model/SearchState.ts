export class SearchState {


  engaged: boolean = false;
  fields: Map<String, String> = new Map<String, String>();


}
export function provideEmptySearchState(): SearchState{
  let state: SearchState = new SearchState()
  state.engaged = false;
  state.fields = new Map<string, string>();
  return state;
}
