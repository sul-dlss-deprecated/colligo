require 'rails_helper'

describe 'shared/_next_record.html.erb' do
  it 'should render the next button with long text truncated' do
    @next_doc = {
      'title' => 'Walters Ms. W.768, Ethiopic Psalter with Canticles, Song of Songs, and two hymns in praise of Mary',
      'path' => '/manuscript/1?start=2'
    }
    render
    expect(rendered).to have_css('div.pull-right a', count: 1)
    expect(rendered).to have_css('div.pull-right a[class="btn btn-lg btn-paginate-next"][href="/manuscript/1?start=2"][id="nextpage"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span[class="glyphicon glyphicon-arrow-right"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span.next_result', text: 'Walters Ms. W.768, Ethiopic Psalter with Cantic...')
    expect(rendered).to include('Walters Ms. W.768,<br/> Ethiopic Psalter with Cantic...')
  end
  it 'should render the next button with text of length 50' do
    @next_doc = {
      'title' => 'Paris, Bibliothèque Nationale de France, NAF 6221',
      'path' => '/manuscript/1?start=2'
    }
    render
    expect(rendered).to have_css('div.pull-right a', count: 1)
    expect(rendered).to have_css('div.pull-right a[class="btn btn-lg btn-paginate-next"][href="/manuscript/1?start=2"][id="nextpage"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span[class="glyphicon glyphicon-arrow-right"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span.next_result', text: 'Paris, Bibliothèque Nationale de France, NAF 6221')
    expect(rendered).to include('Paris, Bibliothèque<br/> Nationale de France, NAF 6221')
  end
  it 'should render the next button with shorter text over two lines' do
    @next_doc = {
      'title' => 'Walters Ms. W.575, Koran',
      'path' => '/manuscript/1?start=2'
    }
    render
    expect(rendered).to have_css('div.pull-right a', count: 1)
    expect(rendered).to have_css('div.pull-right a[class="btn btn-lg btn-paginate-next"][href="/manuscript/1?start=2"][id="nextpage"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span[class="glyphicon glyphicon-arrow-right"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span.next_result', text: 'Walters Ms. W.575, Koran')
    expect(rendered).to include('Walters Ms.<br/> W.575, Koran')
  end
  it 'should render the next button with text over two lines if short and greater than 1 word' do
    @next_doc = {
      'title' => 'Treasury order',
      'path' => '/manuscript/1?start=2'
    }
    render
    expect(rendered).to have_css('div.pull-right a', count: 1)
    expect(rendered).to have_css('div.pull-right a[class="btn btn-lg btn-paginate-next"][href="/manuscript/1?start=2"][id="nextpage"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span[class="glyphicon glyphicon-arrow-right"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span.next_result', text: 'Treasury order')
    expect(rendered).to include('Treasur<br/>y order')
  end
  it 'should render the next button with text over two lines if short and more than 1 word' do
    @next_doc = {
      'title' => 'Que Sera, Sera',
      'path' => '/manuscript/1?start=2'
    }
    render
    expect(rendered).to have_css('div.pull-right a', count: 1)
    expect(rendered).to have_css('div.pull-right a[class="btn btn-lg btn-paginate-next"][href="/manuscript/1?start=2"][id="nextpage"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span[class="glyphicon glyphicon-arrow-right"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span.next_result', text: 'Que Sera, Sera')
    expect(rendered).to include('Que<br/> Sera, Sera')
  end
  it 'should render the next button with text in 1 line if short and 1 word' do
    @next_doc = {
      'title' => 'Dragmaticon',
      'path' => '/manuscript/1?start=2'
    }
    render
    expect(rendered).to have_css('div.pull-right a', count: 1)
    expect(rendered).to have_css('div.pull-right a[class="btn btn-lg btn-paginate-next"][href="/manuscript/1?start=2"][id="nextpage"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span[class="glyphicon glyphicon-arrow-right"]', count: 1)
    expect(rendered).to have_css('div.pull-right a span.next_result', text: 'Dragmaticon')
    expect(rendered).to include('Dragmaticon<br/>')
  end
end
