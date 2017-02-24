require 'rails_helper'

describe '/catalog/bentopage.html.erb' do
  it 'should render the bento page partials' do
    stub_template 'catalog/_bentopage/_results_summary.html.erb' => 'Results summary'
    stub_template 'catalog/_bentopage/_manuscripts.html.erb' => 'Manuscripts'
    stub_template 'catalog/_bentopage/_transcriptions.html.erb' => 'Transcriptions'
    stub_template 'catalog/_bentopage/_annotations.html.erb' => 'Annotations'
    render
    expect(rendered).to match(/Results summary/)
    expect(rendered).to match(/Manuscripts/)
    expect(rendered).to match(/Transcriptions/)
    expect(rendered).to match(/Annotations/)
  end
end
